const { test } = require("node:test");
const assert = require("node:assert/strict");
const G = require("../geometry.js");
const radians = (degrees) => (degrees * Math.PI) / 180;
function close(a, b, tolerance = 2e-9) {
  assert.ok(
    Math.abs(a - b) <= tolerance * Math.max(1, Math.abs(a), Math.abs(b)),
    `${a} != ${b}`,
  );
}
function unit(v) {
  const n = Math.hypot(...v);
  return v.map((x) => x / n);
}
function subtract(a, b) {
  return [a.r - b.r, a.z - b.z];
}
function reflected(incident, normal) {
  const n = unit(normal),
    v = unit(incident),
    dot = v[0] * n[0] + v[1] * n[1];
  return v.map((x, i) => x - 2 * dot * n[i]);
}
for (const sigma of [-1, 1])
  for (const group of ["N", "B", "P"]) {
    const seed =
      group === "N"
        ? G.presets[sigma === -1 ? "cassegrain" : "gregorian"]
        : G.presets[group === "B" ? "blockage" : "phase"];
    const base = G.solve({ ...seed, sigma, group });
    for (let option = 1; option <= 7; option++)
      test(`${sigma === -1 ? "Cassegrain" : "Gregorian"} ${group}${option}: round trip and optical invariants`, () => {
        const d = G.solve({ ...base, group, option });
        for (const key of ["DM", "FM", "LM", "DS", "LS", "A", "FS", "TE"])
          close(d[key], base[key]);
        const b2 = d.sigma * (d.A ** 2 - d.FS ** 2);
        const paths = [];
        for (const fraction of [-1, -0.6, -0.2, 0.2, 0.6, 1]) {
          const ray = G.traceRay(d, d.TE * fraction);
          close(ray.sub.z, G.secondaryZ(d, ray.sub.r));
          close(ray.main.z, G.primaryZ(d, ray.main.r));
          const subNormal = [
            (d.sigma * ray.sub.r) / b2,
            (ray.sub.z - d.center) / d.A ** 2,
          ];
          const actualSub = reflected(subtract(ray.sub, ray.feed), subNormal);
          const expectedSub = unit(subtract(ray.main, ray.sub));
          actualSub.forEach((v, i) => close(v, expectedSub[i]));
          const actualMain = reflected(subtract(ray.main, ray.sub), [
            -ray.main.r / (2 * d.FM),
            1,
          ]);
          close(actualMain[0], 0);
          close(actualMain[1], 1);
          const path =
            Math.hypot(...subtract(ray.sub, ray.feed)) +
            Math.hypot(...subtract(ray.main, ray.sub)) +
            (2 * d.FM - ray.main.z);
          paths.push(path);
        }
        paths.forEach((p) => close(p, paths[0]));
        close(Math.abs(G.traceRay(d, d.TE).main.r), d.DM / 2);
        if (group !== "N")
          close(d.DS, (d.FM * d.DF) / (2 * d.FS - (group === "P" ? d.DPC : 0)));
      });
  }
test("Known original example dimensions", () => {
  const d = G.solve(G.presets.cassegrain);
  close(d.DS, 2.75, 1e-5);
  close(d.LS, 5.0868, 1e-5);
  assert.equal(d.A.toFixed(4), "2.1244");
  close(d.FS, 2.9624);
  const b = G.solve(G.presets.blockage);
  close(b.DS, 1.25);
  close(b.FS, 2);
  close(b.TE, radians(10.0369), 1e-7);
  const p = G.solve(G.presets.phase);
  close(p.DS, 1.5625);
  close(p.FS, 2);
});
test("Zero phase-center recess reduces to minimum blockage", () => {
  const b = G.solve(G.presets.blockage);
  for (const sigma of [-1, 1])
    for (let option = 1; option <= 7; option++) {
      const seed = G.solve({ ...b, sigma, option: 1 });
      const p = G.solve({ ...seed, group: "P", option, DPC: 0 });
      for (const key of ["DM", "FM", "LM", "DS", "LS", "A", "FS", "TE"])
        close(p[key], seed[key]);
    }
});
test("Geometry scales with consistent length units", () => {
  for (const preset of Object.values(G.presets).filter(
    (p) => p.group !== "O",
  )) {
    const base = G.solve(preset);
    for (const factor of [0.001, 1000, 1 / 0.0254]) {
      const p = { ...preset };
      for (const key of ["DM", "FM", "LM", "DS", "LS", "DF", "DPC"])
        p[key] *= factor;
      const scaled = G.solve(p);
      for (const key of [
        "DM",
        "FM",
        "LM",
        "DS",
        "LS",
        "A",
        "FS",
        "depth",
        "subDepth",
        "effectiveFocal",
      ])
        close(scaled[key], base[key] * factor);
      for (const key of [
        "eccentricity",
        "magnification",
        "blockage",
        "focalRatio",
        "TE",
      ])
        close(scaled[key], base[key]);
    }
  }
});
test("Invalid inputs and impossible geometry are rejected", () => {
  const p = G.presets.cassegrain;
  for (const value of [NaN, Infinity, -1, 0, "", null])
    assert.throws(() => G.solve({ ...p, DM: value }));
  for (const TE of [0, radians(90), radians(100)])
    assert.throws(() => G.solve({ ...p, TE }));
  assert.throws(() => G.solve({ ...p, LM: p.FM }));
  assert.throws(() => G.solve({ ...p, option: 6, DS: 30 }));
  assert.throws(() => G.solve({ ...p, sigma: 0 }));
  assert.throws(() => G.solve({ ...p, group: "unknown" }));
  assert.throws(() => G.solve({ ...G.presets.phase, DPC: -1 }));
  assert.throws(() => G.solve({ ...G.presets.phase, DPC: 4 }));
});
test("Quadratic solver handles repeated, linear, complex, and ill-conditioned roots", () => {
  assert.deepEqual(G.quadratic(0, 0, 1), [-0, -0]);
  assert.deepEqual(G.quadratic(-2, 1, 0), [2, 2]);
  assert.throws(() => G.quadratic(1, 0, 1));
  assert.throws(() => G.quadratic(0, 0, 0));
  const roots = G.quadratic(1, -1e12, 1);
  close(roots[0], 1e-12, 1e-20);
  close(roots[1], 1e12);
});
test("Profile samples include vertices and rims with mirror symmetry", () => {
  const d = G.solve(G.presets.cassegrain),
    points = G.profile(d);
  close(points[0].mainR, -d.DM / 2);
  close(points.at(-1).mainR, d.DM / 2);
  close(points[80].mainZ, 0);
  close(points[80].subZ, d.LM + d.LS);
  points.forEach((p, i) => {
    close(p.mainZ, points.at(-1 - i).mainZ);
    close(p.subZ, points.at(-1 - i).subZ);
  });
});

