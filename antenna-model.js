/* Common placed surface representation, shared by visualization and polynomials.
 * Local surface: z = sag(hypot(x,y)); circular aperture centered on (offset,0).
 * Placement is a rotation about y and a translation in the global x-z plane.
 */
(function (root) {
  "use strict";
  const node = typeof module !== "undefined" && module.exports;
  const G = node ? require("./geometry.js") : root.AntennaGeometry;
  const O = node ? require("./open-cassegrain.js") : root.OpenCassegrain;
  function point(s, x, y = 0) {
    const z = s.sag(Math.hypot(x, y));
    return [
      s.origin[0] + x * Math.cos(s.angle) + z * Math.sin(s.angle),
      y,
      s.origin[1] - x * Math.sin(s.angle) + z * Math.cos(s.angle),
    ];
  }
  function section(s, count = 161) {
    return Array.from({ length: count }, (_, i) =>
      point(s, s.offset + s.radius * (-1 + (2 * i) / (count - 1))),
    );
  }
  function fromDesign(d) {
    if (d.scene) return d.scene;
    const main = {
      name: "Main",
      radius: d.DM / 2,
      offset: d.H || 0,
      origin: [0, 0],
      angle: 0,
      quadraticCoefficient: 1 / (4 * d.FM),
      sag: (r) => (r * r) / (4 * d.FM),
    };
    let sub, feed, rays;
    if (d.group === "O") {
      sub = {
        name: "Subreflector",
        radius: d.DS / 2,
        offset: 0,
        origin: [0, d.FM],
        angle: Math.PI - d.THO,
        sag: (r) => d.FS - d.A * Math.sqrt(1 + (r * r) / d.b2),
      };
      feed = [2 * d.FS * Math.sin(d.THO), d.FM - 2 * d.FS * Math.cos(d.THO)];
      rays = Array.from({ length: 11 }, (_, i) =>
        O.traceRay(d, d.H + (d.DM / 2) * (-1 + i / 5)),
      );
    } else {
      sub = {
        name: "Subreflector",
        radius: d.DS / 2,
        offset: 0,
        origin: [0, 0],
        angle: 0,
        sag: (r) => G.secondaryZ(d, r),
      };
      feed = [0, d.LM];
      rays = Array.from({ length: 11 }, (_, i) =>
        G.traceRay(d, d.TE * (-1 + i / 5)),
      );
    }
    const feedAperture = ["B", "P"].includes(d.group)
      ? { x: 0, z: d.LM + (d.group === "P" ? d.DPC : 0), radius: d.DF / 2 }
      : null;
    return {
      name:
        d.group === "O"
          ? "Open-Cassegrain"
          : d.sigma === -1
            ? "Cassegrain"
            : "Gregorian",
      main,
      sub,
      feed,
      feedAperture,
      focus: [0, d.FM],
      rays,
      apertureDiameter: d.DM,
      obstructionRatio: d.group === "O" ? 0 : d.DS / d.DM,
      kind: d.group === "O" ? "open" : "symmetric",
    };
  }
  function profile(scene, count = 401) {
    const main = section(scene.main, count),
      sub = section(scene.sub, count);
    return main.map((p, i) => ({
      mainR: p[0],
      mainZ: p[2],
      subR: sub[i][0],
      subZ: sub[i][2],
    }));
  }
  const api = { point, section, fromDesign, profile };
  if (node) module.exports = api;
  else root.AntennaModel = api;
})(typeof globalThis !== "undefined" ? globalThis : this);

