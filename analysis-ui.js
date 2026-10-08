(function () {
  "use strict";
  const $ = (id) => document.getElementById(id),
    P = window.AntennaPolynomials,
    RF = window.AntennaPattern;
  const units = { m: 1, cm: 0.01, mm: 0.001, in: 0.0254 };
  const fmt = (n, d = 5) => Number(n.toPrecision(d)).toString();
  let context = null,
    pattern = null,
    polyExport = null,
    timer;
  function download(content, type, name) {
    const url = URL.createObjectURL(new Blob([content], { type })),
      a = document.createElement("a");
    a.href = url;
    a.download = name;
    a.click();
    setTimeout(() => URL.revokeObjectURL(url), 1000);
  }
  function el(tag, attrs = {}, text) {
    const node = document.createElementNS("http://www.w3.org/2000/svg", tag);
    Object.entries(attrs).forEach(([k, v]) => node.setAttribute(k, v));
    if (text !== undefined) node.textContent = text;
    return node;
  }
  function drawPattern() {
    const svg = $("pattern-chart");
    svg.replaceChildren();
    if (!pattern) return;
    const width = 900,
      height = 340,
      left = 70,
      right = 24,
      top = 26,
      bottom = 52,
      relative = $("pattern-scale").value === "relative";
    const maximum = relative ? 0 : Math.ceil(pattern.peakGain / 10) * 10,
      minimum = maximum - 60;
    const sx = (a) =>
      left +
      ((a + pattern.maxAngleDeg) / (2 * pattern.maxAngleDeg)) *
        (width - left - right);
    const sy = (g) =>
      top +
      ((maximum - Math.max(minimum, g)) / (maximum - minimum)) *
        (height - top - bottom);
    svg.append(
      el(
        "title",
        {},
        `Estimated ${relative ? "relative power" : "gain"} pattern, ${fmt(pattern.frequencyGHz)} GHz`,
      ),
    );
    svg.append(el("rect", { width, height, fill: "#f8faf3" }));
    for (let db = minimum; db <= maximum; db += 10) {
      svg.append(
        el("line", {
          x1: left,
          x2: width - right,
          y1: sy(db),
          y2: sy(db),
          stroke: "#dde4d4",
        }),
      );
      svg.append(
        el(
          "text",
          {
            x: left - 12,
            y: sy(db) + 4,
            "text-anchor": "end",
            fill: "#66765b",
            "font-size": 12,
          },
          `${db}`,
        ),
      );
    }
    for (let i = -3; i <= 3; i++) {
      const a = (pattern.maxAngleDeg * i) / 3;
      svg.append(
        el("line", {
          x1: sx(a),
          x2: sx(a),
          y1: top,
          y2: height - bottom,
          stroke: "#e2e7da",
        }),
      );
      svg.append(
        el(
          "text",
          {
            x: sx(a),
            y: height - bottom + 21,
            "text-anchor": "middle",
            fill: "#66765b",
            "font-size": 11,
          },
          fmt(a, 3),
        ),
      );
    }
    const halfPower = (relative ? 0 : pattern.peakGain) - 3.01029995664;
    svg.append(
      el("line", {
        x1: left,
        x2: width - right,
        y1: sy(halfPower),
        y2: sy(halfPower),
        stroke: "#b39758",
        "stroke-dasharray": "4 5",
      }),
    );
    const points = pattern.samples
      .map(
        (p) => `${sx(p.angleDeg)},${sy(relative ? p.relativeDb : p.gainDbi)}`,
      )
      .join(" ");
    svg.append(
      el("polyline", {
        points,
        fill: "none",
        stroke: "#57723b",
        "stroke-width": 2,
        "stroke-linejoin": "round",
      }),
    );
    svg.append(
      el(
        "text",
        { x: left, y: 16, fill: "#66765b", "font-size": 11 },
        relative ? "Relative power (dB)" : "Gain (dBi)",
      ),
    );
    svg.append(
      el(
        "text",
        {
          x: width / 2,
          y: height - 8,
          "text-anchor": "middle",
          fill: "#66765b",
          "font-size": 12,
        },
        "Off-axis angle (degrees)",
      ),
    );
  }
  function calculatePattern() {
    pattern = null;
    $("export-pattern").disabled = true;
    for (const id of [
      "peak-gain",
      "beamwidth",
      "wavelength",
      "total-efficiency",
    ])
      $(id).textContent = "—";
    $("pattern-chart").replaceChildren();
    if (!context?.scene) {
      $("pattern-status").textContent =
        "Enter a valid design to calculate a pattern.";
      return;
    }
    try {
      const get = (id) =>
        $(id).value.trim() === "" ? NaN : Number($(id).value);
      pattern = RF.calculate({
        diameter: context.scene.apertureDiameter * units[context.unit],
        obstructionRatio: context.scene.obstructionRatio,
        frequencyGHz: get("frequency"),
        edgeTaperDb: get("edge-taper"),
        efficiency: get("rf-efficiency") / 100,
        span: get("pattern-span"),
      });
      $("peak-gain").textContent = `${fmt(pattern.peakGain, 5)} dBi`;
      $("beamwidth").textContent = `${fmt(pattern.hpbwDeg, 4)}°`;
      $("wavelength").textContent = `${fmt(pattern.wavelength * 1000, 5)} mm`;
      $("total-efficiency").textContent =
        `${fmt(pattern.totalEfficiency * 100, 4)}%`;
      $("pattern-status").textContent =
        `D/λ = ${fmt(pattern.electricalDiameter)} · far-field distance ≳ ${fmt(pattern.farField)} m · central obstruction = ${fmt(100 * pattern.obstructionRatio, 4)}% of diameter. Chart floor is 60 dB below its top gridline.`;
      $("export-pattern").disabled = false;
      drawPattern();
    } catch (error) {
      $("pattern-status").textContent = error.message;
    }
  }
  function updatePolynomials() {
    polyExport = null;
    $("export-polynomial").disabled = true;
    $("export-functions").disabled = true;
    $("edit-current-polynomial").disabled = true;
    $("polynomial-summary").textContent = "";
    $("poly-fit-status").textContent = "";
    if (!context?.scene) return;
    try {
      polyExport = context.polynomial
        ? P.validate(context.polynomial)
        : P.exportDesign(
            context.scene,
            context.unit,
            Number($("poly-degree").value),
          );
      const lines = [];
      for (const key of ["main", "sub"]) {
        const s = polyExport[key];
        lines.push(
          `${key === "main" ? "MAIN" : "SUBREFLECTOR"}: zLocal(u) = ${P.expression(s.coefficients)}`,
          `u = (r − ${fmt(s.rOrigin, 8)}) / ${fmt(s.rScale, 8)};  r ∈ [${fmt(s.rMin, 8)}, ${fmt(s.rMax, 8)}] ${context.unit}`,
        );
        if (s.fitError)
          lines.push(
            `Sampled max error: ${s.fitError.max.toExponential(3)} ${context.unit}; RMS: ${s.fitError.rms.toExponential(3)} ${context.unit}`,
          );
        lines.push("");
      }
      $("polynomial-summary").textContent = lines.join("\n");
      $("poly-fit-status").textContent = context.polynomial
        ? "Original imported coefficients preserved."
        : "Fit residuals sampled at 2,001 points per profile.";
      $("poly-degree").disabled = !!context.polynomial;
      $("export-polynomial").disabled = false;
      $("export-functions").disabled = false;
      $("edit-current-polynomial").disabled = false;
    } catch (error) {
      $("poly-fit-status").textContent = error.message;
    }
  }
  window.addEventListener("antenna-design", (e) => {
    context = e.detail;
    clearTimeout(timer);
    calculatePattern();
    updatePolynomials();
    $("polynomial-pattern-note").hidden = !context.polynomial;
  });
  for (const id of ["frequency", "edge-taper", "rf-efficiency"])
    $(id).addEventListener("input", () => {
      clearTimeout(timer);
      pattern = null;
      $("export-pattern").disabled = true;
      $("pattern-chart").replaceChildren();
      for (const metric of [
        "peak-gain",
        "beamwidth",
        "wavelength",
        "total-efficiency",
      ])
        $(metric).textContent = "—";
      $("pattern-status").textContent = "Updating pattern…";
      timer = setTimeout(calculatePattern, 100);
    });
  $("pattern-span").addEventListener("change", calculatePattern);
  $("pattern-scale").addEventListener("change", drawPattern);
  $("poly-degree").addEventListener("change", updatePolynomials);
  $("export-pattern").addEventListener("click", () => {
    if (!pattern) return;
    const lines = [
      `# Scalar flat-phase circular aperture; frequency_GHz=${pattern.frequencyGHz}; diameter_m=${context.scene.apertureDiameter * units[context.unit]}; edge_taper_dB=${pattern.edgeTaperDb}; other_efficiency=${pattern.efficiency}; obstruction_ratio=${pattern.obstructionRatio}`,
      "angle_deg,relative_power_dB,gain_dBi",
      ...pattern.samples.map((p) =>
        [p.angleDeg, p.relativeDb, p.gainDbi]
          .map((n) => n.toPrecision(12))
          .join(","),
      ),
    ];
    download(lines.join("\n") + "\n", "text/csv", "antenna-pattern.csv");
  });
  $("export-polynomial").addEventListener("click", () => {
    if (polyExport)
      download(
        JSON.stringify(polyExport, null, 2),
        "application/json",
        "antenna-polynomial.json",
      );
  });
  $("export-functions").addEventListener("click", () => {
    if (polyExport)
      download(P.report(polyExport), "text/plain", "antenna-functions.txt");
  });
  $("edit-current-polynomial").addEventListener("click", () => {
    if (polyExport) {
      $("polynomial-json").value = JSON.stringify(polyExport, null, 2);
      $("poly-import-status").textContent =
        "Edit either the ascending coefficients or replace them with an expression in u.";
    }
  });
  function apply(text) {
    if (text.length > 100000)
      throw new Error("Polynomial files must be smaller than 100 KB.");
    const data = P.validate(JSON.parse(text));
    P.scene(data);
    window.dispatchEvent(
      new CustomEvent("antenna-polynomial-import", { detail: data }),
    );
    $("poly-import-status").textContent =
      "Polynomial design applied. Geometry and exports now use these functions.";
  }
  $("apply-polynomial").addEventListener("click", () => {
    try {
      apply($("polynomial-json").value);
    } catch (error) {
      $("poly-import-status").textContent = `Could not apply: ${error.message}`;
    }
  });
  $("open-polynomial").addEventListener("click", () =>
    $("polynomial-file").click(),
  );
  $("polynomial-file").addEventListener("change", async (e) => {
    const file = e.target.files[0];
    if (!file) return;
    try {
      if (file.size > 100000)
        throw new Error("Polynomial files must be smaller than 100 KB.");
      const text = await file.text();
      apply(text);
      $("polynomial-json").value = text;
    } catch (error) {
      $("poly-import-status").textContent = `Could not open: ${error.message}`;
    } finally {
      e.target.value = "";
    }
  });
})();

