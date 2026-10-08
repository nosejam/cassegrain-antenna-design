/* Equations: Christophe Granet. Original Fortran: T. A. Milligan.
 * Ports of GRANET.FOR DRGEON1–7, DRGEOB1–7, DRGEOP1–7.
 * Lengths use one consistent unit; TE is in radians in this module.
 * This file works both directly in a browser and in Node for verification.
 */
(function (root) {
  "use strict";
  const { sin, cos, tan, atan, sqrt, abs } = Math;
  const O =
    typeof module !== "undefined" && module.exports
      ? require("./open-cassegrain.js")
      : root.OpenCassegrain;
  const angleKeys = ["TE", "THO", "THMR", "THEM"];
  const inputs = {
    N: [
      ["DM", "LM", "LS", "TE"],
      ["DM", "FM", "LM", "TE"],
      ["DM", "FM", "LS", "TE"],
      ["FM", "DS", "LS", "TE"],
      ["LM", "DS", "LS", "TE"],
      ["DM", "FM", "DS", "TE"],
      ["DM", "DS", "LS", "TE"],
    ],
    B: [
      ["DM", "FM", "LM", "DF"],
      ["DM", "FM", "TE", "DF"],
      ["DM", "FM", "DS", "DF"],
      ["DM", "LM", "DS", "DF"],
      ["DM", "DS", "TE", "DF"],
      ["DM", "LM", "TE", "DF"],
      ["DM", "LS", "TE", "DF"],
    ],
  };
  inputs.P = inputs.B.map((keys) => [...keys, "DPC"]);
  inputs.O = O.inputs;
  const labels = {
    DM: "Main reflector diameter",
    FM: "Main focal length",
    LM: "Vertex to feed phase center",
    DS: "Subreflector diameter",
    LS: "Feed to subreflector vertex",
    TE: "Feed half-angle",
    DF: "Feed aperture diameter",
    DPC: "Phase-center recess",
    A: "Conic semi-axis a",
    FS: "Half interfocal distance c",
    THO: "Main reflector offset angle",
    DISTM: "Main surface to feed clearance",
    THMR: "Secondary half-angle at main focus",
    THEM: "Secondary edge angle at Q",
    H: "Main aperture center offset",
  };
  const presets = {
    cassegrain: {
      sigma: -1,
      group: "N",
      option: 2,
      DM: 22,
      FM: 7.379,
      LM: 1.4542,
      DS: 2.75,
      LS: 5.0868,
      TE: (14 * Math.PI) / 180,
      DF: 1,
      DPC: 0.8,
    },
    gregorian: {
      sigma: 1,
      group: "N",
      option: 2,
      DM: 10,
      FM: 3.0928,
      LM: 1,
      DS: 1.1898,
      LS: 2.5,
      TE: (15 * Math.PI) / 180,
      DF: 1,
      DPC: 0.8,
    },
    blockage: {
      sigma: -1,
      group: "B",
      option: 1,
      DM: 10,
      FM: 5,
      LM: 1,
      DS: 1.25,
      LS: 3.4024,
      TE: (10.0369 * Math.PI) / 180,
      DF: 1,
      DPC: 0.8,
    },
    phase: {
      sigma: -1,
      group: "P",
      option: 1,
      DM: 10,
      FM: 5,
      LM: 1,
      DS: 1.5625,
      LS: 3.2628,
      TE: (12.8892 * Math.PI) / 180,
      DF: 1,
      DPC: 0.8,
    },
    open: {
      sigma: -1,
      group: "O",
      option: 2,
      DM: 100,
      FM: 71.0844,
      THO: (53.931 * Math.PI) / 180,
      DS: 30,
      TE: (14 * Math.PI) / 180,
      DISTM: 4,
    },
    open2: {
      sigma: -1,
      group: "O",
      option: 2,
      DM: 50,
      FM: 32.5142,
      THO: (56.6898 * Math.PI) / 180,
      DS: 15,
      TE: (16 * Math.PI) / 180,
      DISTM: 4,
    },
  };

  // QUADR uses a cancellation-resistant formulation. Coefficients are constant first.
  function quadratic(c, b, a) {
    const scale = Math.max(abs(a), abs(b), abs(c));
    if (!Number.isFinite(scale) || scale === 0)
      throw new Error(
        "The design is singular. Choose a different parameter combination.",
      );
    a /= scale;
    b /= scale;
    c /= scale;
    if (a === 0) {
      if (b === 0)
        throw new Error("The design equations have no unique solution.");
      return [-c / b, -c / b];
    }
    let d = b * b - 4 * a * c;
    if (d < -32 * Number.EPSILON * (b * b + abs(4 * a * c)))
      throw new Error(
        "These inputs give complex roots: no real antenna geometry exists.",
      );
    d = Math.max(0, d);
    const q = -(b + (b < 0 ? -1 : 1) * sqrt(d)) / 2;
    if (q === 0) return [-b / (2 * a), -b / (2 * a)];
    return [q / a, c / q].sort((x, y) => x - y);
  }
  const maxRoot = (...args) => Math.max(...quadratic(...args));
  const minRoot = (...args) => Math.min(...quadratic(...args));
  function positiveRoot(...args) {
    const r = quadratic(...args);
    return r[0] * r[1] > 0 ? Math.min(...r) : Math.max(...r);
  }

  // Direct equation ports; raw is exported to compare even nonphysical legacy outputs.
  function raw(parameters) {
    let {
      sigma: s = -1,
      group = "N",
      option = 2,
      DM,
      FM,
      LM,
      DS,
      LS,
      TE,
      DF,
      DPC = 0,
    } = parameters;
    let A, FS;
    const h = tan(TE / 2),
      t = tan(TE),
      u = sin(TE);
    if (group === "N") {
      switch (option) {
        case 1: // Equations 4–7
          FS = (LS * (s * DM - 4 * LM * h)) / (2 * s * DM + 8 * LS * h);
          FM = LM + 2 * FS;
          A = LS - FS;
          DS =
            (4 * A) / (1 / u + (s * (16 * FM ** 2 + DM ** 2)) / (8 * FM * DM));
          break;
        case 2: {
          // Equations 8–11
          A =
            (-0.5 * (LM - FM) * (s * DM + 4 * FM * h)) / (s * DM - 4 * FM * h);
          LS = (-s * DM * (LM - FM)) / (s * DM - 4 * FM * h);
          FS = (FM - LM) / 2;
          const x1 = -16 * u * DM * FM * (LM - FM) * (s * DM + 4 * FM * h);
          const x2 = 8 * FM * DM * (s * DM - 4 * FM * h);
          const x3 = (DM ** 2 + 16 * FM ** 2) * u * (DM - 4 * s * FM * h);
          DS = x1 / (x2 + x3);
          break;
        }
        case 3: // Equations 12–15
          LM = -(s * DM * (LS - FM) - 4 * LS * FM * h) / (s * DM);
          DS =
            (16 * u * FM * LS * (s * DM + 4 * FM * h)) /
            (8 * s * FM * DM + u * (DM ** 2 + 16 * FM ** 2));
          A = (LS * (s * DM + 4 * FM * h)) / (2 * s * DM);
          FS = (LS * (s * DM - 4 * FM * h)) / (2 * s * DM);
          break;
        case 4: // Equation 16, then 12, 14, 15
          DM = maxRoot(
            16 * FM ** 2 * u * (DS - 4 * LS * h),
            8 * FM * s * (DS - 2 * u * LS),
            DS * u,
          );
          LM = -(s * DM * (LS - FM) - 4 * LS * FM * h) / (s * DM);
          A = (LS * (s * DM + 4 * FM * h)) / (2 * s * DM);
          FS = (LS * (s * DM - 4 * FM * h)) / (2 * s * DM);
          break;
        case 5: // Equation 17, then 5, 6, 18
          FS = minRoot(
            LS ** 2 * (h * u * (8 * LS - h * DS) - DS * (2 * h + u)),
            4 * DS * LS * (u + h) - 24 * LS ** 2 * h * u,
            4 * u * (4 * LS * h - DS),
          );
          FM = LM + 2 * FS;
          A = LS - FS;
          DM = (4 * LS * h * FM) / (s * (LS - 2 * FS));
          break;
        case 6: {
          // Equations 19–23
          const x1 = h * FM,
            x2 = 8 * FM * DM + s * u * (16 * FM ** 2 + DM ** 2);
          const x3 =
            8 * s * DM ** 2 * FM * (DS - 2 * u * FM) -
            32 * h * FM ** 2 * DM * (DS + 2 * u * FM) -
            4 * DS * s * u * h * FM * (16 * FM ** 2 + DM ** 2) +
            DS * u * DM * (16 * FM ** 2 + DM ** 2);
          LS = (DS * s * x2) / (16 * u * FM * (s * DM + 4 * x1));
          A = (DS * x2) / (32 * u * DM * FM);
          FS =
            (DS * x2 * (s * DM - 4 * x1)) /
            (32 * u * FM * (s * DM + 4 * x1) * DM);
          LM = -x3 / (16 * DM * u * FM * (s * DM + 4 * x1));
          break;
        }
        case 7: // Equation 24, then 12, 14, 15
          FM = positiveRoot(
            -DS * DM ** 2 * u,
            8 * DM * s * (2 * u * LS - DS),
            16 * u * (4 * LS * h - DS),
          );
          LM = -(s * DM * (LS - FM) - 4 * LS * FM * h) / (s * DM);
          A = (LS * (s * DM + 4 * FM * h)) / (2 * s * DM);
          FS = (LS * (s * DM - 4 * FM * h)) / (2 * s * DM);
          break;
        default:
          throw new Error("Unknown design option.");
      }
    } else if (group === "B" || group === "P") {
      const pc = group === "P" ? DPC : 0;
      switch (option) {
        case 1:
          FS = (FM - LM) / 2;
          DS = (FM * DF) / (2 * FS - pc);
          break;
        case 2:
          if (group === "B")
            FS = sqrt(
              (8 * FM * DM * DF - s * DF * t * (16 * FM ** 2 - DM ** 2)) /
                (64 * t * DM),
            );
          else {
            const z3 = 8 * FM * DM - s * t * (16 * FM ** 2 - DM ** 2);
            FS =
              (maxRoot(
                -16 * DF * FM ** 2 * t * DM,
                -16 * pc * t * FM * DM,
                z3,
              ) *
                z3) /
              (32 * FM * DM * t);
          }
          LM = FM - 2 * FS;
          DS = (FM * DF) / (2 * FS - pc);
          break;
        case 3:
          FS = ((FM * DF) / DS + pc) / 2;
          LM = FM - 2 * FS;
          break;
        case 4:
          FS = (DS * pc + LM * DF) / (2 * (DS - DF));
          FM = LM + 2 * FS;
          break;
        case 5:
          FM =
            group === "B"
              ? maxRoot(
                  -s * DS ** 2 * DM ** 2,
                  (-8 * DM * DS ** 2) / t,
                  16 * (DF * DM + s * DS ** 2),
                )
              : maxRoot(
                  -t * s * DS ** 2 * DM ** 2,
                  16 * t * DM * DS * pc - 8 * DM * DS ** 2,
                  16 * t * (DF * DM + s * DS ** 2),
                );
          FS = ((FM * DF) / DS + pc) / 2;
          LM = FM - 2 * FS;
          break;
        case 6:
          if (group === "B") {
            FM = maxRoot(
              t * DM * (16 * LM ** 2 - s * DF * DM),
              -8 * DM * (4 * LM * t + DF),
              16 * t * (DM + s * DF),
            );
            FS = (FM - LM) / 2;
          } else {
            FS = maxRoot(
              s * t * DF * (16 * LM ** 2 - DM ** 2) - 8 * DM * DF * LM,
              32 * t * (2 * s * DF * LM - DM * pc) - 16 * DM * DF,
              64 * t * (DM + s * DF),
            );
            FM = LM + 2 * FS;
          }
          DS = (FM * DF) / (2 * FS - pc);
          break;
        case 7:
          if (group === "B") {
            FM = positiveRoot(
              t * DM ** 2 * (16 * LS ** 2 - s * DF * DM),
              -8 * DM * (16 * LS ** 2 * s * t * h + DF * DM),
              16 * t * (16 * LS ** 2 * h ** 2 + s * DF * DM),
            );
            FS = (-LS * (4 * FM * h - s * DM)) / (2 * s * DM);
          } else {
            FS = maxRoot(
              s * DF * DM * LS ** 2 * (t * (1 - h ** 2) - 2 * h),
              4 * s * DM * DF * LS * (h - t) - 32 * t * pc * LS ** 2 * h ** 2,
              4 * t * ((4 * LS * h) ** 2 + s * DF * DM),
            );
            FM = (s * DM * (LS - 2 * FS)) / (4 * h * LS);
          }
          LM = FM - 2 * FS;
          DS = (FM * DF) / (2 * FS - pc);
          break;
        default:
          throw new Error("Unknown design option.");
      }
      if ([1, 3, 4].includes(option))
        TE = atan(
          (8 * FM * DM * DS) /
            (32 * FS * FM * DM + s * DS * (16 * FM ** 2 - DM ** 2)),
        );
      LS = (2 * s * DM * FS) / (s * DM - 4 * FM * tan(TE / 2));
      A = LS - FS;
    } else throw new Error("Unknown design constraint.");
    return { sigma: s, group, option, DM, FM, LM, DS, LS, TE, DF, DPC, A, FS };
  }

  function solve(parameters) {
    if (parameters.group === "O") return O.solve(parameters);
    const { group, option, sigma } = parameters;
    if (!inputs[group]?.[option - 1] || ![-1, 1].includes(sigma))
      throw new Error("Choose a supported antenna and input combination.");
    for (const key of inputs[group][option - 1]) {
      const n = parameters[key];
      if (typeof n !== "number" || !Number.isFinite(n))
        throw new Error(
          `Enter a finite number for ${labels[key].toLowerCase()}.`,
        );
      if (key === "TE") {
        if (n <= 0 || n >= Math.PI / 2)
          throw new Error(
            "Feed half-angle must be greater than 0° and less than 90°.",
          );
      } else if (key === "DPC") {
        if (n < 0)
          throw new Error("Phase-center recess must be zero or positive.");
      } else if (key !== "LM" && n <= 0)
        throw new Error(`${labels[key]} must be greater than zero.`);
    }
    const d = raw(parameters);
    for (const key of ["DM", "FM", "DS", "LS", "A", "FS", "LM", "TE"]) {
      if (!Number.isFinite(d[key]))
        throw new Error(
          "This combination produces a singular or non-real solution. Adjust the inputs.",
        );
      if (key !== "LM" && d[key] <= 0)
        throw new Error(
          `The calculated ${labels[key].toLowerCase()} is not positive. Adjust the inputs.`,
        );
    }
    if (d.TE >= Math.PI / 2)
      throw new Error("The calculated feed half-angle must be below 90°.");
    if (d.DS >= d.DM)
      throw new Error(
        "The subreflector must be smaller than the main reflector.",
      );
    d.b2 = sigma * (d.A ** 2 - d.FS ** 2);
    if (d.b2 <= 1e-12 * Math.max(d.A ** 2, d.FS ** 2))
      throw new Error(
        "The subreflector is degenerate or has the wrong conic type for this antenna.",
      );
    if (sigma === 1 && (d.DS / 2) ** 2 >= d.b2)
      throw new Error(
        "The subreflector rim exceeds the supported upper ellipsoid branch.",
      );
    d.center = d.LM + d.FS;
    d.vertex = d.LM + d.LS;
    d.depth = d.DM ** 2 / (16 * d.FM);
    d.eccentricity = d.FS / d.A;
    d.magnification = (d.A + d.FS) / abs(d.A - d.FS);
    d.effectiveFocal = d.FM * d.magnification;
    d.focalRatio = d.FM / d.DM;
    d.blockage = (d.DS / d.DM) ** 2;
    d.subDepth = abs(secondaryZ(d, d.DS / 2) - d.vertex);
    d.routine = `DRGEO${group}${option}`;
    if (d.vertex <= 0 || secondaryZ(d, d.DS / 2) <= d.depth)
      throw new Error(
        "The reflectors overlap or are reversed along the axis. Adjust the geometry.",
      );
    const edge = traceRay(d, d.TE);
    if (
      abs(edge.main.r - (sigma * -d.DM) / 2) > d.DM * 1e-7 ||
      abs(edge.sub.r - d.DS / 2) > d.DM * 1e-7
    ) {
      throw new Error(
        "This root does not produce a consistent rim-to-rim ray on the supported reflector branches.",
      );
    }
    d.warnings = [];
    if (d.LM < 0)
      d.warnings.push(
        "The feed phase center is behind the main vertex; the main reflector needs a central opening.",
      );
    if (d.blockage > 0.1)
      d.warnings.push(
        "The subreflector covers more than 10% of the projected aperture area.",
      );
    if (d.group !== "N" && d.DPC >= d.LS && d.group === "P")
      d.warnings.push(
        "The feed aperture reaches or passes the subreflector vertex.",
      );
    return d;
  }

  function primaryZ(d, r) {
    return (r * r) / (4 * d.FM);
  }
  function secondaryZ(d, r) {
    return d.center + d.A * sqrt(1 - (d.sigma * r * r) / d.b2);
  }

  // A ray from the feed intersects the actual conic, then its focal line
  // intersects the parabola. The resulting beam travels parallel to +z.
  function traceRay(d, angle) {
    const rho = (d.FS ** 2 - d.A ** 2) / (d.FS * cos(angle) - d.A);
    const sub = { r: rho * sin(angle), z: d.LM + rho * cos(angle) };
    const dr = -d.sigma * sub.r,
      dz = d.sigma * (d.FM - sub.z);
    const norm = Math.hypot(dr, dz),
      ur = dr / norm,
      uz = dz / norm;
    // From the focus, parabola distance along the outgoing unit direction.
    const distance = (2 * d.FM) / (1 - uz);
    const main = { r: distance * ur, z: d.FM + distance * uz };
    return { feed: { r: 0, z: d.LM }, sub, main };
  }
  function profile(d, count = 161) {
    return Array.from({ length: count }, (_, i) => {
      const t = -1 + (2 * i) / (count - 1),
        rm = (t * d.DM) / 2,
        rs = (t * d.DS) / 2;
      return {
        mainR: rm,
        mainZ: primaryZ(d, rm),
        subR: rs,
        subZ: secondaryZ(d, rs),
      };
    });
  }
  const api = {
    inputs,
    labels,
    presets,
    angleKeys,
    quadratic,
    raw,
    solve,
    primaryZ,
    secondaryZ,
    traceRay,
    profile,
  };
  if (typeof module !== "undefined" && module.exports) module.exports = api;
  else root.AntennaGeometry = api;
})(typeof globalThis !== "undefined" ? globalThis : this);

