/* Open-Cassegrain equations from GRANEOC.FOR, OCAGEO1–5.
 * Angles in radians; lengths in a consistent unit. Bracketed bisection replaces
 * the legacy fixed scan/30-iteration solver. See README for the ASR discrepancy.
 */
(function (root) {
  "use strict";
  const { sin, cos, tan, atan, acos, sqrt, PI } = Math;
  const inputs = [
    ["FM", "THO", "DS", "TE"],
    ["DM", "FM", "DS", "TE"],
    ["DM", "FM", "THO", "TE"],
    ["DM", "THO", "DS", "DISTM"],
    ["DM", "DS", "TE", "DISTM"],
  ];
  function bisect(fn, lo, hi) {
    let fl = fn(lo),
      fh = fn(hi);
    if (!Number.isFinite(fl + fh) || fl * fh > 0)
      throw new Error(
        "No open-Cassegrain solution in the supported angle range. Adjust the known parameters.",
      );
    for (let i = 0; i < 100; i++) {
      const mid = (lo + hi) / 2,
        fm = fn(mid);
      if (!Number.isFinite(fm))
        throw new Error(
          "The open-Cassegrain equations are singular for these inputs.",
        );
      if (fm === 0 || hi - lo < 2e-14) return mid;
      if (fl * fm <= 0) {
        hi = mid;
        fh = fm;
      } else {
        lo = mid;
        fl = fm;
      }
    }
    return (lo + hi) / 2;
  }
  function scanRoot(fn, lo, hi, reverse = false) {
    if (!(lo < hi))
      throw new Error(
        "No open-Cassegrain solution below a 90° offset for this feed angle.",
      );
    let previous, previousX;
    for (let i = 0; i <= 1000; i++) {
      const x = reverse
        ? hi - ((hi - lo) * i) / 1000
        : lo + ((hi - lo) * i) / 1000;
      const value = fn(x);
      if (
        Number.isFinite(value) &&
        Number.isFinite(previous) &&
        value * previous <= 0
      )
        return bisect(fn, Math.min(x, previousX), Math.max(x, previousX));
      previous = value;
      previousX = x;
    }
    throw new Error(
      "No real open-Cassegrain root was found. Try a smaller secondary or another offset angle.",
    );
  }
  const diameter = (f, o, h) => (4 * f * sin(h)) / (cos(h) + cos(o));
  const subDiameter = (f, o, h) =>
    (4 * f * sin(o - h) * sin(h)) / ((1 + cos(o - h)) * sin(o + h));
  // Equations 1 & 2 imply DS/DM = sin((THO-THMR)/2)/sin((THO+THMR)/2).
  const halfAngle = (o, ratio) =>
    2 * atan(((1 - ratio) / (1 + ratio)) * tan(o / 2));
  const focal = (dm, o, h) => (dm * (cos(h) + cos(o))) / (4 * sin(h));
  const betaFromAngles = (h, e) => sin(h - e) / (sin(e) + sin(h));
  const halfFoci = (ds, b, e) =>
    (ds * (cos(e) - b)) / (2 * (1 - b * b) * sin(e));
  function solve(p) {
    const option = p.option;
    if (!inputs[option - 1])
      throw new Error("Choose an open-Cassegrain option from 1 to 5.");
    for (const key of inputs[option - 1]) {
      if (!Number.isFinite(p[key]) || p[key] <= 0)
        throw new Error(`${key} must be a finite positive number.`);
      if (["THO", "TE"].includes(key) && p[key] >= PI / 2)
        throw new Error(`${key} must be between 0° and 90°.`);
    }
    let { DM, FM, DS, THO, TE, DISTM } = p,
      THMR,
      FS,
      beta;
    const epsilon = 1e-8;
    if ([2, 4, 5].includes(option) && DS >= DM)
      throw new Error(
        "The subreflector must be smaller than the main reflector.",
      );
    if (option === 1) {
      THMR = scanRoot(
        (h) => subDiameter(FM, THO, h) - DS,
        epsilon,
        THO - epsilon,
        true,
      );
      DM = diameter(FM, THO, THMR);
    } else if (option === 2) {
      THO = bisect(
        (o) => focal(DM, o, halfAngle(o, DS / DM)) - FM,
        epsilon,
        PI / 2 - epsilon,
      );
      THMR = halfAngle(THO, DS / DM);
    } else if (option === 3) {
      THMR = bisect((h) => diameter(FM, THO, h) - DM, epsilon, THO - epsilon);
      DS = subDiameter(FM, THO, THMR);
    } else if (option === 4) {
      THMR = halfAngle(THO, DS / DM);
      FM = focal(DM, THO, THMR);
      FS = FM / (1 + cos(THO)) - DISTM / 2;
      const a = 2 * FS * sin(THMR),
        b = DS,
        c = DS * cos(THMR) - a;
      const discriminant = b * b - 4 * a * c;
      if (FS <= 0 || discriminant < 0)
        throw new Error("The feed clearance produces an impossible hyperbola.");
      beta = (-2 * c) / (b + sqrt(discriminant));
      if (!(beta > 0 && beta < 1))
        throw new Error(
          "The requested feed clearance gives a non-hyperbolic secondary.",
        );
      TE = acos(
        Math.min(
          1,
          ((1 + beta * beta) * cos(THMR) + 2 * beta) /
            (1 + beta * beta + 2 * beta * cos(THMR)),
        ),
      );
    } else {
      const q = (1 - DS / DM) / (1 + DS / DM);
      const lo = 2 * atan(tan(TE / 2) / q) + epsilon;
      THO = scanRoot(
        (o) => {
          const h = halfAngle(o, DS / DM),
            f = focal(DM, o, h),
            b = betaFromAngles(h, TE);
          return (2 * f) / (1 + cos(o)) - 2 * halfFoci(DS, b, TE) - DISTM;
        },
        lo,
        PI / 2 - epsilon,
      );
      THMR = halfAngle(THO, DS / DM);
      FM = focal(DM, THO, THMR);
    }
    beta = betaFromAngles(THMR, TE);
    if (!(beta > 0 && beta < 1) || !(DS > 0 && DS < DM))
      throw new Error(
        "Feed half-angle must be below the secondary half-angle at the main focus.",
      );
    FS = halfFoci(DS, beta, TE);
    DISTM = (2 * FM) / (1 + cos(THO)) - 2 * FS;
    const EC = 1 / beta,
      A = FS * beta,
      b2 = FS * FS - A * A;
    const ASR = (DS * (EC * cos(TE) - 1)) / (2 * (EC * EC - 1) * cos(TE));
    const THEM = atan(
      (DS * (1 + cos(THO)) * tan(THMR)) /
        (4 * FM * tan(THMR) - DS * (1 + cos(THO))),
    );
    const H = FM * (tan((THO - THMR) / 2) + tan((THO + THMR) / 2));
    const clearance =
      2 * FM * tan((THO - THMR) / 2) -
      (FS * (1 - beta * beta) * sin(THO + THMR)) / (cos(THMR) + beta);
    if (
      ![DM, FM, DS, FS, A, H, DISTM].every(Number.isFinite) ||
      DISTM <= 0 ||
      b2 <= 0
    )
      throw new Error(
        "The feed must lie between the secondary and the main surface (positive DISTM).",
      );
    const warnings = [
      "Open geometry is at the theoretical beam-clearance boundary; allow mechanical margin.",
      "The source ASR is inconsistent with c/e. Surface geometry uses a = c/e; legacy ASR is shown separately.",
    ];
    return {
      group: "O",
      sigma: -1,
      option,
      DM,
      FM,
      DS,
      THO,
      TE,
      THMR,
      THEM,
      DISTM,
      FS,
      EC,
      A,
      ASR,
      b2,
      H,
      clearance,
      focalRatio: FM / DM,
      eccentricity: EC,
      magnification: (FS + A) / (FS - A),
      blockage: 0,
      depth: ((H + DM / 2) ** 2 - (H - DM / 2) ** 2) / (4 * FM),
      subDepth: A * (sqrt(1 + (DS / 2) ** 2 / b2) - 1),
      routine: `OCAGEO${option}`,
      warnings,
    };
  }
  function traceRay(d, mainR) {
    const main = { r: mainR, z: (mainR * mainR) / (4 * d.FM) };
    const vx = main.r,
      vz = main.z - d.FM,
      n = Math.hypot(vx, vz);
    const ux = vx / n,
      uz = vz / n;
    const rho = d.b2 / (d.FS * (ux * sin(d.THO) - uz * cos(d.THO)) + d.A);
    return {
      feed: { r: 2 * d.FS * sin(d.THO), z: d.FM - 2 * d.FS * cos(d.THO) },
      sub: { r: rho * ux, z: d.FM + rho * uz },
      main,
    };
  }
  const api = { inputs, solve, traceRay };
  if (typeof module !== "undefined" && module.exports) module.exports = api;
  else root.OpenCassegrain = api;
})(typeof globalThis !== "undefined" ? globalThis : this);

