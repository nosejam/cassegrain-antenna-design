const { test } = require("node:test");
const assert = require("node:assert/strict");
const G = require("../geometry"),
  O = require("../open-cassegrain"),
  M = require("../antenna-model"),
  P = require("../polynomials"),
  RF = require("../pattern");
function close(a, b, tolerance = 1e-9) {
  assert.ok(
    Math.abs(a - b) <= tolerance * Math.max(1, Math.abs(a), Math.abs(b)),
    `${a} != ${b}`,
  );
}
function norm(v) {
  const n = Math.hypot(...v);
  return v.map((x) => x / n);
}
function reflect(v, n) {
  v = norm(v);
  n = norm(n);
  const dot = v.reduce((s, x, i) => s + x * n[i], 0);
  return v.map((x, i) => x - 2 * dot * n[i]);
}
for (const name of ["open", "open2"])
  for (let option = 1; option <= 5; option++)
    test(`${name} option ${option}: round trip, actual surfaces, optical invariants`, () => {
      const base = G.solve(G.presets[name]),
        d = O.solve({ ...base, option }),
        s = M.fromDesign(d);
      for (const key of [
        "DM",
        "FM",
        "DS",
        "TE",
        "THO",
        "THMR",
        "FS",
        "A",
        "DISTM",
      ])
        close(d[key], base[key], 1e-9);
      close(d.A, d.FS / d.EC);
      close(d.ASR, d.A * Math.tan(d.TE));
      close(d.clearance, 0, 1e-9);
      const a = s.sub.angle,
        c = Math.cos(a),
        sn = Math.sin(a),
        paths = [];
      for (const ray of s.rays) {
        const dx = ray.sub.r - s.sub.origin[0],
          dz = ray.sub.z - s.sub.origin[1];
        const localX = dx * c - dz * sn,
          localZ = dx * sn + dz * c;
        close(localZ, s.sub.sag(Math.abs(localX)));
        const nx =
          (-d.A * localX) / (d.b2 * Math.sqrt(1 + (localX * localX) / d.b2));
        // Surface normal for t=c-a*sqrt(1+r²/b²) is [-dt/dr,1].
        const normal = [-nx * c + sn, nx * sn + c];
        const incoming = [ray.sub.r - ray.feed.r, ray.sub.z - ray.feed.z];
        const expected = norm([ray.main.r - ray.sub.r, ray.main.z - ray.sub.z]);
        const actual = reflect(incoming, normal);
        actual.forEach((x, i) => close(x, expected[i]));
        const out = reflect(
          [ray.main.r - ray.sub.r, ray.main.z - ray.sub.z],
          [-ray.main.r / (2 * d.FM), 1],
        );
        close(out[0], 0);
        close(out[1], 1);
        paths.push(
          Math.hypot(...incoming) +
            Math.hypot(ray.main.r - ray.sub.r, ray.main.z - ray.sub.z) -
            ray.main.z,
        );
      }
      paths.forEach((x) => close(x, paths[0]));
      for (const ray of [s.rays[0], s.rays.at(-1)]) {
        const dx = ray.sub.r - s.sub.origin[0],
          dz = ray.sub.z - s.sub.origin[1];
        close(Math.abs(dx * c - dz * sn), d.DS / 2);
        const v = norm([ray.sub.r - ray.feed.r, ray.sub.z - ray.feed.z]);
        close(Math.acos(v[0] * -sn + v[1] * -c), d.TE);
      }
    });
test("Open-Cassegrain placement, circular rim mapping and scale invariance", () => {
  const base = G.solve(G.presets.open);
  for (const factor of [0.001, 1000]) {
    const p = { ...base };
    for (const key of ["DM", "FM", "DS", "DISTM"]) p[key] *= factor;
    const d = O.solve(p);
    for (const key of ["DM", "FM", "DS", "FS", "A", "H", "DISTM"])
      close(d[key], base[key] * factor);
    close(d.THO, base.THO);
    close(d.TE, base.TE);
  }
  const scene = M.fromDesign(base),
    focus = [0, 0, base.FM];
  for (let i = 0; i < 32; i++) {
    const phi = (i * Math.PI) / 16,
      p = M.point(
        scene.main,
        base.H + (base.DM / 2) * Math.cos(phi),
        (base.DM / 2) * Math.sin(phi),
      );
    const v = norm(p.map((x, j) => x - focus[j]));
    close(
      v[0] * Math.sin(base.THO) - v[2] * Math.cos(base.THO),
      Math.cos(base.THMR),
    );
  }
});
test("Open-Cassegrain impossible inputs are rejected", () => {
  for (const patch of [
    { DM: 0 },
    { DS: 101 },
    { TE: Math.PI / 2 },
    { FM: NaN },
    { option: 9 },
  ])
    assert.throws(() => O.solve({ ...G.presets.open, ...patch }));
  assert.throws(() => O.solve({ ...G.presets.open, option: 4, DISTM: 1000 }));
  assert.throws(() => O.solve({ ...G.presets.open, option: 5, TE: 1.5 }));
});
for (const name of ["cassegrain", "gregorian", "open", "open2"])
  test(`${name}: polynomial export/import retains placement and bounded profile error`, () => {
    const scene = M.fromDesign(G.solve(G.presets[name])),
      data = P.exportDesign(scene, "m", 8),
      loaded = P.scene(data);
    assert.deepEqual(loaded.feed, scene.feed);
    for (const key of ["main", "sub"]) {
      assert.deepEqual(loaded[key].origin, scene[key].origin);
      close(loaded[key].angle, scene[key].angle);
      assert.ok(data[key].fitError.max < 1e-6);
      for (let i = 0; i <= 100; i++) {
        const r =
          data[key].rMin + ((data[key].rMax - data[key].rMin) * i) / 100;
        assert.ok(
          Math.abs(scene[key].sag(r) - loaded[key].sag(r)) <=
            data[key].fitError.max + 1e-11,
        );
      }
    }
    const mm = P.scene(P.rescale(data, "mm"));
    for (const key of ["main", "sub"])
      for (const r of [0, 0.3, 1]) {
        const original = M.point(
          loaded[key],
          loaded[key].offset + r * loaded[key].radius,
        );
        const scaled = M.point(mm[key], mm[key].offset + r * mm[key].radius);
        original.forEach((x, i) => close(scaled[i], x * 1000));
      }
  });
test("Higher-degree polynomial fits improve the secondary approximation", () => {
  const scene = M.fromDesign(G.solve(G.presets.cassegrain));
  const low = P.exportDesign(scene, "m", 2),
    high = P.exportDesign(scene, "m", 10);
  assert.ok(high.sub.fitError.max < low.sub.fitError.max / 1e5);
  assert.ok(high.main.coefficients.length <= 3);
});
test("Polynomial parser handles arithmetic without evaluating JavaScript", () => {
  assert.deepEqual(P.parse("6.54 + 0.22*u^2"), [6.54, 0, 0.22]);
  assert.deepEqual(P.parse("(u-1)^2/4"), [0.25, -0.5, 0.25]);
  assert.deepEqual(P.parse("-u^2 + 1e-3*u"), [0, 0.001, -1]);
  for (const expression of [
    "alert(1)",
    "globalThis.x=1",
    "u^-1",
    "u^13",
    "1/u",
    "1/0",
    "u**2",
    "2u",
    "sin(u)",
    "(u+1",
    "1e999",
  ])
    assert.throws(() => P.parse(expression));
});
test("Polynomial schema rejects incomplete or inconsistent definitions", () => {
  const source = P.exportDesign(M.fromDesign(G.solve(G.presets.open)), "m");
  for (const change of [
    (p) => (p.main.rScale = 0),
    (p) => (p.main.rMax = 1),
    (p) => (p.main.axisAngleDeg = 5),
    (p) => (p.sub.coefficients = [Infinity]),
    (p) => (p.unit = "yards"),
    (p) => (p.feed = [0]),
    (p) => (p.obstructionRatio = 1),
    (p) => (p.sub.expression = "u^2"),
  ]) {
    const p = structuredClone(source);
    change(p);
    assert.throws(() => P.validate(p));
  }
  const p = structuredClone(source);
  delete p.main.coefficients;
  p.main.expression = "0.01*u^2+0.2*u+20";
  const s = P.scene(p);
  close(s.main.sag(p.main.rOrigin), 20);
});
test("Bessel function agrees with reference values", () => {
  for (const [x, y] of [
    [0, 1],
    [1, 0.7651976865579666],
    [12, 0.04768931079683354],
    [20, 0.16702466434058315],
    [40, 0.00736689058423729],
  ])
    close(RF.j0(x), y, 2e-11);
});
test("Uniform clear-aperture pattern reproduces Airy null, amplitude, gain and beamwidth", () => {
  const p = RF.calculate({
    diameter: 1,
    frequencyGHz: 10,
    edgeTaperDb: 0,
    efficiency: 1,
  });
  close(p.amplitude(0), 1);
  close(p.amplitude(1), 0.880101171489867, 1e-9);
  close(p.amplitude(3.8317059702075125), 0, 1e-9);
  close(p.apertureEfficiency, 1);
  close(p.peakGain, 10 * Math.log10((Math.PI / p.wavelength) ** 2));
  close(
    p.hpbwDeg,
    (2 *
      Math.asin(1.616339948310703 / (Math.PI * p.electricalDiameter)) *
      180) /
      Math.PI,
    1e-8,
  );
});
test("Frequency, taper, obstruction and loss produce the expected changes", () => {
  const p = RF.calculate({
    diameter: 1,
    frequencyGHz: 10,
    edgeTaperDb: 0,
    efficiency: 1,
  });
  const high = RF.calculate({
    diameter: 1,
    frequencyGHz: 20,
    edgeTaperDb: 0,
    efficiency: 1,
  });
  close(high.peakGain - p.peakGain, 20 * Math.log10(2));
  close(high.wavelength, p.wavelength / 2);
  assert.ok(high.hpbwDeg < p.hpbwDeg * 0.501);
  const blocked = RF.calculate({
    diameter: 1,
    frequencyGHz: 10,
    edgeTaperDb: 0,
    efficiency: 0.5,
    obstructionRatio: 0.2,
  });
  close(blocked.apertureEfficiency, (1 - 0.2 ** 2) ** 2);
  close(
    blocked.peakGain - p.peakGain,
    10 * Math.log10(0.5 * (1 - 0.2 ** 2) ** 2),
  );
  const tapered = RF.calculate({
    diameter: 1,
    frequencyGHz: 10,
    edgeTaperDb: -15,
    efficiency: 1,
  });
  assert.ok(tapered.hpbwDeg > p.hpbwDeg);
  assert.ok(tapered.peakGain < p.peakGain);
  const samples = tapered.samples;
  for (let i = 0; i < samples.length; i++)
    close(samples[i].relativeDb, samples.at(-1 - i).relativeDb, 1e-8);
});
test("Pattern validity limits and invalid settings are enforced", () => {
  for (const patch of [
    { frequencyGHz: 0 },
    { frequencyGHz: NaN },
    { diameter: 0.001 },
    { edgeTaperDb: 10 },
    { efficiency: 0 },
    { obstructionRatio: 1 },
    { span: 100 },
  ])
    assert.throws(() =>
      RF.calculate({ diameter: 1, frequencyGHz: 10, ...patch }),
    );
});

