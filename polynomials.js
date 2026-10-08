(function (root) {
  "use strict";
  const node = typeof module !== "undefined" && module.exports;
  const M = node ? require("./antenna-model.js") : root.AntennaModel;
  const unitFactors = { m: 1, cm: 0.01, mm: 0.001, in: 0.0254 };
  function evaluate(coefficients, u) {
    return coefficients.reduceRight((value, c) => value * u + c, 0);
  }
  function add(a, b, sign = 1) {
    const c = Array(Math.max(a.length, b.length)).fill(0);
    c.forEach((_, i) => (c[i] = (a[i] || 0) + sign * (b[i] || 0)));
    return c;
  }
  function multiply(a, b) {
    if (a.length + b.length > 14)
      throw new Error("Polynomial degree must not exceed 12.");
    const c = Array(a.length + b.length - 1).fill(0);
    a.forEach((x, i) => b.forEach((y, j) => (c[i + j] += x * y)));
    return c;
  }
  // A small polynomial grammar, never JavaScript evaluation. Supports u, numbers,
  // scientific notation, + - * / (constant only), integer powers, and parentheses.
  function parse(expression) {
    if (typeof expression !== "string" || expression.length > 2000)
      throw new Error(
        "Enter a polynomial expression in u (up to 2000 characters).",
      );
    const tokens =
      expression.match(
        /(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?|u|[+\-*/^()]/g,
      ) || [];
    if (tokens.join("") !== expression.replace(/\s/g, ""))
      throw new Error(
        "Only numbers, u, + - * / ^ and parentheses are allowed. Use explicit multiplication.",
      );
    let index = 0;
    function atom() {
      const token = tokens[index++];
      if (token === "(") {
        const a = sum();
        if (tokens[index++] !== ")")
          throw new Error("Unclosed polynomial parentheses.");
        return a;
      }
      if (token === "u") return [0, 1];
      if (token && Number.isFinite(Number(token))) return [Number(token)];
      throw new Error("Expected a number, u, or parentheses.");
    }
    function power() {
      let a = atom();
      if (tokens[index] === "^") {
        index++;
        const n = Number(tokens[index++]);
        if (!Number.isInteger(n) || n < 0 || n > 12)
          throw new Error("Powers must be integers from 0 to 12.");
        const base = a;
        a = [1];
        for (let i = 0; i < n; i++) a = multiply(a, base);
      }
      return a;
    }
    function signed() {
      if (tokens[index] === "+") {
        index++;
        return signed();
      }
      if (tokens[index] === "-") {
        index++;
        return signed().map((x) => -x);
      }
      return power();
    }
    function product() {
      let a = signed();
      while (["*", "/"].includes(tokens[index])) {
        const op = tokens[index++],
          b = signed();
        if (op === "*") a = multiply(a, b);
        else {
          if (b.length !== 1 || b[0] === 0)
            throw new Error(
              "Division is supported only by a nonzero constant.",
            );
          a = a.map((x) => x / b[0]);
        }
      }
      return a;
    }
    function sum() {
      let a = product();
      while (["+", "-"].includes(tokens[index])) {
        const op = tokens[index++];
        a = add(a, product(), op === "+" ? 1 : -1);
      }
      return a;
    }
    const coefficients = sum();
    if (index !== tokens.length || !coefficients.every(Number.isFinite))
      throw new Error("Invalid or overflowing polynomial expression.");
    return coefficients;
  }
  function expression(coefficients) {
    return (
      coefficients
        .map((c, i) =>
          c === 0
            ? ""
            : `${c < 0 ? "-" : "+"}${Math.abs(c).toPrecision(14)}${i ? `*u${i > 1 ? `^${i}` : ""}` : ""}`,
        )
        .filter(Boolean)
        .join(" ")
        .replace(/^\+/, "") || "0"
    );
  }
  function fit(surface, degree) {
    const rMin = Math.max(0, Math.abs(surface.offset) - surface.radius),
      rMax = Math.abs(surface.offset) + surface.radius;
    const rOrigin = (rMin + rMax) / 2,
      rScale = (rMax - rMin) / 2;
    const n = degree + 1,
      values = Array.from({ length: n }, (_, i) =>
        surface.sag(rOrigin + rScale * Math.cos((Math.PI * (i + 0.5)) / n)),
      );
    let previous = [1],
      current = [0, 1],
      coefficients = [values.reduce((a, b) => a + b, 0) / n];
    for (let k = 1; k <= degree; k++) {
      const ck =
        (2 / n) *
        values.reduce(
          (v, y, i) => v + y * Math.cos((k * Math.PI * (i + 0.5)) / n),
          0,
        );
      coefficients = add(
        coefficients,
        current.map((x) => x * ck),
      );
      const next = add([0, ...current.map((x) => 2 * x)], previous, -1);
      previous = current;
      current = next;
    }
    const scale = Math.max(...coefficients.map(Math.abs));
    coefficients = coefficients.map((c) =>
      Math.abs(c) < scale * 1e-13 ? 0 : c,
    );
    while (coefficients.length > 1 && coefficients.at(-1) === 0)
      coefficients.pop();
    // Preserve the analytic parabola exactly instead of exporting fitting noise.
    if (Number.isFinite(surface.quadraticCoefficient)) {
      const q = surface.quadraticCoefficient;
      coefficients = [
        q * rOrigin * rOrigin,
        2 * q * rOrigin * rScale,
        q * rScale * rScale,
      ];
    }
    let maxError = 0,
      sum2 = 0;
    for (let i = 0; i <= 2000; i++) {
      const u = -1 + i / 1000,
        error = evaluate(coefficients, u) - surface.sag(rOrigin + rScale * u);
      maxError = Math.max(maxError, Math.abs(error));
      sum2 += error * error;
    }
    return {
      coefficients,
      rOrigin,
      rScale,
      rMin,
      rMax,
      apertureRadius: surface.radius,
      apertureOffset: surface.offset,
      origin: [...surface.origin],
      axisAngleDeg: (surface.angle * 180) / Math.PI,
      fitError: { max: maxError, rms: Math.sqrt(sum2 / 2001), samples: 2001 },
    };
  }
  function exportDesign(scene, unit, degree = 8) {
    if (!Number.isInteger(degree) || degree < 2 || degree > 12)
      throw new Error("Choose a polynomial degree from 2 to 12.");
    return {
      format: "cassegrain-polynomial",
      version: 1,
      unit,
      name: `${scene.name} polynomial profiles`,
      convention:
        "zLocal = sum(coefficients[i] * u^i), u = (r - rOrigin) / rScale; r = hypot(xLocal,yLocal). Lengths use unit. Angles are degrees.",
      main: fit(scene.main, degree),
      sub: fit(scene.sub, degree),
      feed: [...scene.feed],
      obstructionRatio: scene.obstructionRatio,
    };
  }
  function validate(data) {
    if (
      !data ||
      data.format !== "cassegrain-polynomial" ||
      data.version !== 1 ||
      !Object.hasOwn(unitFactors, data.unit)
    )
      throw new Error(
        "Expected a version 1 cassegrain-polynomial file with unit m, cm, mm, or in.",
      );
    const clean = {
      format: data.format,
      version: 1,
      unit: data.unit,
      name:
        typeof data.name === "string"
          ? data.name.slice(0, 100)
          : "Polynomial design",
    };
    if (
      !Array.isArray(data.feed) ||
      data.feed.length !== 2 ||
      !data.feed.every(Number.isFinite)
    )
      throw new Error("feed must contain [global x, global z].");
    clean.feed = [...data.feed];
    if (
      !Number.isFinite(data.obstructionRatio) ||
      data.obstructionRatio < 0 ||
      data.obstructionRatio >= 0.95
    )
      throw new Error("obstructionRatio must be between 0 and 0.95.");
    clean.obstructionRatio = data.obstructionRatio;
    for (const key of ["main", "sub"]) {
      const s = data[key];
      if (!s || typeof s !== "object")
        throw new Error(`Missing ${key} profile.`);
      if (s.expression !== undefined && s.coefficients !== undefined)
        throw new Error(
          `${key}: use either expression or coefficients, not both.`,
        );
      const coefficients =
        s.expression !== undefined ? parse(s.expression) : s.coefficients;
      if (
        !Array.isArray(coefficients) ||
        coefficients.length < 1 ||
        coefficients.length > 13 ||
        !coefficients.every(Number.isFinite)
      )
        throw new Error(
          `${key}: coefficients must be 1–13 finite numbers in ascending power order.`,
        );
      for (const field of [
        "rOrigin",
        "rScale",
        "rMin",
        "rMax",
        "apertureRadius",
        "apertureOffset",
        "axisAngleDeg",
      ])
        if (!Number.isFinite(s[field]))
          throw new Error(`${key}: ${field} must be finite.`);
      if (
        s.rMin < 0 ||
        s.rMax <= s.rMin ||
        s.rScale <= 0 ||
        s.apertureRadius <= 0
      )
        throw new Error(`${key}: invalid radial domain or aperture radius.`);
      const lo = Math.max(0, Math.abs(s.apertureOffset) - s.apertureRadius),
        hi = Math.abs(s.apertureOffset) + s.apertureRadius;
      const tolerance = s.apertureRadius * 1e-10;
      if (lo < s.rMin - tolerance || hi > s.rMax + tolerance)
        throw new Error(
          `${key}: radial domain does not cover the entire aperture.`,
        );
      if (
        !Array.isArray(s.origin) ||
        s.origin.length !== 2 ||
        !s.origin.every(Number.isFinite)
      )
        throw new Error(`${key}: origin must contain [global x, global z].`);
      if (Math.abs(s.axisAngleDeg) > 180)
        throw new Error(`${key}: axisAngleDeg must be between -180 and 180.`);
      if (key === "main" && Math.abs(s.axisAngleDeg) > 1e-10)
        throw new Error(
          "The imported main reflector axis must face +z (axisAngleDeg = 0).",
        );
      clean[key] = Object.fromEntries(
        [
          "rOrigin",
          "rScale",
          "rMin",
          "rMax",
          "apertureRadius",
          "apertureOffset",
          "axisAngleDeg",
        ].map((k) => [k, s[k]]),
      );
      clean[key].origin = [...s.origin];
      clean[key].coefficients = [...coefficients];
      for (let i = 0; i <= 512; i++) {
        const r = lo + ((hi - lo) * i) / 512,
          z = evaluate(coefficients, (r - s.rOrigin) / s.rScale);
        if (!Number.isFinite(z) || Math.abs(z) > 1e8 * s.apertureRadius)
          throw new Error(
            `${key}: polynomial overflows or has an impractical extent within its aperture.`,
          );
      }
    }
    return clean;
  }
  function scene(data) {
    const p = validate(data);
    function surface(key) {
      const s = p[key];
      return {
        name: key === "main" ? "Main" : "Subreflector",
        radius: s.apertureRadius,
        offset: s.apertureOffset,
        origin: s.origin,
        angle: (s.axisAngleDeg * Math.PI) / 180,
        sag: (r) => evaluate(s.coefficients, (r - s.rOrigin) / s.rScale),
      };
    }
    return {
      name: p.name,
      main: surface("main"),
      sub: surface("sub"),
      feed: p.feed,
      focus: null,
      rays: [],
      kind: "polynomial",
      apertureDiameter: 2 * p.main.apertureRadius,
      obstructionRatio: p.obstructionRatio,
    };
  }
  function rescale(data, nextUnit) {
    const p = validate(data);
    if (!Object.hasOwn(unitFactors, nextUnit))
      throw new Error("Unknown length unit.");
    const factor = unitFactors[p.unit] / unitFactors[nextUnit];
    p.unit = nextUnit;
    p.feed = p.feed.map((n) => n * factor);
    for (const key of ["main", "sub"]) {
      for (const field of [
        "rOrigin",
        "rScale",
        "rMin",
        "rMax",
        "apertureRadius",
        "apertureOffset",
      ])
        p[key][field] *= factor;
      p[key].origin = p[key].origin.map((n) => n * factor);
      p[key].coefficients = p[key].coefficients.map((n) => n * factor);
    }
    return p;
  }
  function report(data) {
    const lines = [
      `${data.name}`,
      `Length unit: ${data.unit}`,
      "Each polynomial describes a LOCAL radial surface, not necessarily the global cross-section.",
      "r = hypot(xLocal, yLocal). Coefficients are in ascending power order.",
    ];
    for (const key of ["main", "sub"]) {
      const s = data[key];
      lines.push(
        "",
        key.toUpperCase(),
        `u = (r - ${s.rOrigin}) / ${s.rScale}`,
        `zLocal(u) = ${expression(s.coefficients)}`,
        `Domain: ${s.rMin} <= r <= ${s.rMax}`,
        `Aperture: radius ${s.apertureRadius}, local x offset ${s.apertureOffset}`,
        `Origin [global x, global z]: [${s.origin.join(", ")}]; axis angle: ${s.axisAngleDeg} deg`,
      );
      if (s.fitError)
        lines.push(
          `Sampled fit error (${s.fitError.samples} points): max ${s.fitError.max}, RMS ${s.fitError.rms} ${data.unit}`,
        );
    }
    lines.push(
      "",
      "Placement: global x = originX + xLocal*cos(angle) + zLocal*sin(angle)",
      "global y = yLocal",
      "global z = originZ - xLocal*sin(angle) + zLocal*cos(angle)",
      `Feed phase center [x,z]: [${data.feed.join(", ")}]`,
      "A hyperbola/ellipse is not a finite polynomial: exported secondary profiles are approximations over the stated domain.",
    );
    return lines.join("\n");
  }
  const api = {
    evaluate,
    parse,
    expression,
    fit,
    exportDesign,
    validate,
    scene,
    rescale,
    report,
  };
  if (node) module.exports = api;
  else root.AntennaPolynomials = api;
})(typeof globalThis !== "undefined" ? globalThis : this);

