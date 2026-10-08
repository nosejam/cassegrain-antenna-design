(function () {
  "use strict";
  const G = window.AntennaGeometry;
  const M = window.AntennaModel,
    P = window.AntennaPolynomials;
  const isAngle = (key) => G.angleKeys.includes(key);
  const $ = (id) => document.getElementById(id);
  const RAD = Math.PI / 180;
  const units = { m: 1, cm: 0.01, mm: 0.001, in: 0.0254 };
  let state = { ...G.presets.cassegrain },
    unit = "m",
    lastPreset = "cassegrain";
  let design = null,
    view = "2d",
    zoom = 1,
    yaw = 0.9,
    pitch = 0.32;
  let polynomial = null;
  let showRays = true,
    showDimensions = true;
  const fmt = (n, digits = 4) =>
    Number.isFinite(n)
      ? Number(n.toPrecision(digits)).toLocaleString("en-US", {
          maximumSignificantDigits: digits,
        })
      : "—";
  const numericText = (n) => Number(n.toPrecision(12)).toString();
  const length = (n) => `${fmt(n, 6)} ${unit}`;
  const description = {
    N: "Choose four known values; solve the remaining geometry. No minimum-blockage condition.",
    B: "Matches the projected feed and subreflector blockage using the feed aperture diameter.",
    P: "Includes a feed phase center recessed behind its aperture, using the original DPC equations.",
    O: "Open-Cassegrain geometry with a circular offset main aperture and tilted hyperbolic secondary.",
    poly: "Imported polynomial surfaces. Edit the functions in the polynomial panel below, or choose a conic starting example.",
  };
  const help = {
    DM: "Projected aperture, edge to edge.",
    FM: "Main vertex to the main focus.",
    LM: "Signed axial distance from the main vertex.",
    LS: "Axial distance from phase center to secondary vertex.",
    DS: "Projected secondary aperture.",
    TE: "From the feed axis to the subreflector rim.",
    DF: "Diameter at the feed aperture.",
    DPC: "Distance into the feed from its aperture.",
    THO: "From the parent main axis to its central ray.",
    DISTM: "Measured along the tilted axis from the main surface to the feed.",
  };
  function known() {
    return state.group === "poly"
      ? []
      : G.inputs[state.group][state.option - 1];
  }
  function setCustom() {
    $("preset").value = "custom";
    $("file-status").textContent = "";
  }
  function keepSolution() {
    if (design)
      for (const key of Object.keys(G.labels))
        if (Number.isFinite(design[key])) state[key] = design[key];
  }
  function buildControls() {
    $("antenna").value =
      state.group === "O"
        ? "open"
        : state.group === "poly"
          ? "poly"
          : state.sigma;
    $("constraint").value = state.group;
    $("constraint").disabled = ["O", "poly"].includes(state.group);
    $("option").disabled = state.group === "poly";
    $("unit").value = unit;
    $("option").replaceChildren(
      ...(G.inputs[state.group] || []).map((keys, i) => {
        const o = document.createElement("option");
        o.value = i + 1;
        o.textContent = `${i + 1} · ${keys.join(", ")}`;
        return o;
      }),
    );
    $("option").value = state.option;
    $("mode-description").textContent = description[state.group];
    $("parameters").replaceChildren(
      ...known().map((key) => {
        const field = document.createElement("div");
        const label = document.createElement("label");
        label.htmlFor = `input-${key}`;
        label.className = "parameter-title";
        const name = document.createElement("span");
        name.textContent = G.labels[key];
        const symbol = document.createElement("code");
        symbol.textContent = key;
        label.append(name, symbol);
        const wrap = document.createElement("div");
        wrap.className = "input-wrap";
        const input = document.createElement("input");
        input.type = "number";
        input.step = "any";
        input.id = `input-${key}`;
        input.value = Number.isFinite(state[key])
          ? numericText(isAngle(key) ? state[key] / RAD : state[key])
          : "";
        input.required = true;
        input.setAttribute("aria-describedby", `help-${key}`);
        if (key !== "LM") input.min = "0";
        if (isAngle(key)) input.max = "90";
        input.addEventListener("input", () => {
          state[key] =
            input.value === ""
              ? NaN
              : Number(input.value) * (isAngle(key) ? RAD : 1);
          setCustom();
          update();
        });
        const suffix = document.createElement("span");
        suffix.className = "input-unit";
        suffix.textContent = isAngle(key) ? "deg" : unit;
        wrap.append(input, suffix);
        const hint = document.createElement("small");
        hint.id = `help-${key}`;
        hint.className = "parameter-help";
        hint.textContent = help[key];
        field.append(label, wrap, hint);
        return field;
      }),
    );
  }
  $("parameters").addEventListener("submit", (e) => e.preventDefault());
  function loadPreset(name) {
    lastPreset = name;
    state = { ...G.presets[name] };
    polynomial = null;
    for (const key of Object.keys(G.labels))
      if (!isAngle(key) && Number.isFinite(state[key]))
        state[key] /= units[unit];
    zoom = 1;
    $("preset").value = name;
    $("file-status").textContent = "";
    buildControls();
    update();
  }
  $("preset").addEventListener("change", (e) => loadPreset(e.target.value));
  $("reset").addEventListener("click", () => loadPreset(lastPreset));
  $("antenna").addEventListener("change", (e) => {
    if (e.target.value === "open") {
      loadPreset("open");
      return;
    }
    if (["O", "poly"].includes(state.group)) {
      loadPreset(e.target.value === "1" ? "gregorian" : "cassegrain");
      return;
    }
    keepSolution();
    state.sigma = Number(e.target.value);
    setCustom();
    buildControls();
    update();
  });
  $("constraint").addEventListener("change", (e) => {
    keepSolution();
    state.group = e.target.value;
    state.option = state.group === "N" ? 2 : 1;
    setCustom();
    buildControls();
    update();
  });
  $("option").addEventListener("change", (e) => {
    keepSolution();
    state.option = Number(e.target.value);
    setCustom();
    buildControls();
    update();
  });
  $("unit").addEventListener("change", (e) => {
    if (polynomial) {
      polynomial = P.rescale(polynomial, e.target.value);
      unit = e.target.value;
      buildControls();
      update();
      return;
    }
    keepSolution();
    const factor = units[unit] / units[e.target.value];
    unit = e.target.value;
    for (const key of Object.keys(G.labels))
      if (!isAngle(key) && Number.isFinite(state[key])) state[key] *= factor;
    buildControls();
    update();
  });
  function status(message, className) {
    const p = document.createElement("p");
    p.className = className;
    p.textContent = message;
    $("validation").append(p);
  }
  function update() {
    $("validation").replaceChildren();
    try {
      if (polynomial) {
        const scene = P.scene(polynomial);
        design = {
          scene,
          group: "poly",
          DM: scene.apertureDiameter,
          DS: scene.sub.radius * 2,
          blockage: scene.obstructionRatio ** 2,
          routine: "POLYNOMIAL",
          warnings: [
            "Profiles loaded. Optical validity and collimation are not established.",
          ],
        };
        status("✓ Polynomial profiles loaded", "valid");
      } else {
        design = G.solve(state);
        status("✓ Valid reflector geometry", "valid");
      }
      design.warnings.forEach((w) => status(w, "warning"));
    } catch (error) {
      design = null;
      status(error.message, "invalid");
    }
    for (const key of known()) {
      const invalid =
        !Number.isFinite(state[key]) ||
        (key !== "LM" && (key === "DPC" ? state[key] < 0 : state[key] <= 0)) ||
        (isAngle(key) && state[key] >= Math.PI / 2);
      $(`input-${key}`).setAttribute("aria-invalid", String(invalid));
    }
    $("plot-error").hidden = !!design;
    for (const id of ["export-json", "export-csv", "export-svg"])
      $(id).disabled = !design;
    $("metric-ratio").textContent = design ? fmt(design.focalRatio) : "—";
    $("metric-diameter").textContent = design
      ? `${fmt(design.DS)} ${unit}`
      : "—";
    $("metric-diameter-note").textContent = design
      ? `${fmt((100 * design.DS) / design.DM, 3)}% of main diameter`
      : "—";
    $("metric-magnification").textContent = Number.isFinite(
      design?.magnification,
    )
      ? `${fmt(design.magnification)}×`
      : "—";
    $("metric-blockage").textContent = design
      ? `${fmt(100 * design.blockage, 3)}%`
      : "—";
    $("routine").textContent =
      design?.routine ||
      (state.group === "O"
        ? `OCAGEO${state.option}`
        : `DRGEO${state.group}${state.option}`);
    const rows =
      state.group === "O"
        ? [
            ["Main diameter · DM", "DM"],
            ["Parent focal length · FM", "FM"],
            ["Main aperture offset · H", "H"],
            ["Main offset angle · THO", "THO"],
            ["Secondary diameter · DS", "DS"],
            ["Feed half-angle · TE", "TE"],
            ["Consistent semi-axis · c/e", "A"],
            ["Legacy source semi-axis · ASR", "ASR"],
            ["Half interfocal distance · c", "FS"],
            ["Main surface to feed · DISTM", "DISTM"],
            ["Secondary half-angle · THMR", "THMR"],
            ["Beam clearance", "clearance"],
          ]
        : [
            ["Main diameter · DM", "DM"],
            ["Main focal length · FM", "FM"],
            ["Feed phase center · LM", "LM"],
            ["Feed to secondary · LS", "LS"],
            ["Subreflector diameter · DS", "DS"],
            ["Feed half-angle · TE", "TE"],
            ["Conic semi-axis · a", "A"],
            ["Half interfocal distance · c", "FS"],
            ["Main reflector depth", "depth"],
            ["Subreflector depth", "subDepth"],
            ["Subreflector eccentricity", "eccentricity"],
            ["Effective focal length", "effectiveFocal"],
          ];
    $("results-grid").replaceChildren(
      ...rows.map(([label, key]) => {
        const row = document.createElement("div");
        row.className = "result-row";
        const name = document.createElement("span");
        name.textContent = label;
        const value = document.createElement("strong");
        value.textContent = !Number.isFinite(design?.[key])
          ? "—"
          : isAngle(key)
            ? `${fmt(design[key] / RAD, 6)}°`
            : key === "eccentricity"
              ? fmt(design[key], 6)
              : length(design[key]);
        row.append(name, value);
        return row;
      }),
    );
    $("plot-label").textContent =
      state.group === "O"
        ? "OPEN-CASSEGRAIN / OFFSET APERTURE"
        : polynomial
          ? "IMPORTED POLYNOMIAL PROFILES"
          : `${state.sigma === -1 ? "CASSEGRAIN" : "GREGORIAN"} / AXIALLY SYMMETRIC`;
    $("show-rays").disabled = !!polynomial;
    $("plot-unit").textContent = unit;
    render();
    window.dispatchEvent(
      new CustomEvent("antenna-design", {
        detail: {
          design,
          scene: design ? M.fromDesign(design) : null,
          unit,
          polynomial,
        },
      }),
    );
  }

  function sectionSvg(d, width = 900, height = 560, exportMode = false) {
    return window.AntennaView.section(M.fromDesign(d), {
      width,
      height,
      zoom,
      rays: showRays,
      dimensions: showDimensions,
      unit,
      exported: exportMode,
    });
  }
  function render3D(d) {
    const rect = $("plot").getBoundingClientRect();
    window.AntennaView.model($("model"), M.fromDesign(d), {
      width: rect.width,
      height: rect.height,
      zoom,
      yaw,
      pitch,
      rays: showRays,
      dimensions: showDimensions,
      unit,
    });
  }
  function render() {
    if (!design) {
      $("section").replaceChildren();
      const ctx = $("model").getContext("2d");
      ctx.clearRect(0, 0, $("model").width, $("model").height);
      return;
    }
    if (view === "3d") render3D(design);
    else {
      const rect = $("plot").getBoundingClientRect();
      const svg = sectionSvg(design, Math.max(rect.width, 300), rect.height);
      $("section").setAttribute("viewBox", svg.getAttribute("viewBox"));
      $("section").replaceChildren(...svg.childNodes);
    }
  }
  function setView(next) {
    view = next;
    zoom = 1;
    $("section").toggleAttribute("hidden", view !== "2d");
    $("model").hidden = view !== "3d";
    $("view-2d").setAttribute("aria-pressed", String(view === "2d"));
    $("view-3d").setAttribute("aria-pressed", String(view === "3d"));
    $("geometry-title").textContent =
      view === "2d" ? "Axial cross-section" : "Reflector surfaces";
    $("view-hint").textContent =
      view === "2d"
        ? "Equal scale on both axes · z →"
        : "Drag or arrow keys to rotate · +/− to zoom";
    render();
  }
  $("view-2d").addEventListener("click", () => setView("2d"));
  $("view-3d").addEventListener("click", () => setView("3d"));
  $("show-rays").addEventListener("change", (e) => {
    showRays = e.target.checked;
    render();
  });
  $("show-dimensions").addEventListener("change", (e) => {
    showDimensions = e.target.checked;
    render();
  });
  function changeZoom(factor) {
    zoom = Math.min(4, Math.max(0.4, zoom * factor));
    render();
  }
  $("zoom-in").addEventListener("click", () => changeZoom(1.2));
  $("zoom-out").addEventListener("click", () => changeZoom(1 / 1.2));
  $("fit").addEventListener("click", () => {
    zoom = 1;
    yaw = 0.9;
    pitch = 0.32;
    render();
  });
  let drag = null;
  $("model").addEventListener("pointerdown", (e) => {
    drag = { x: e.clientX, y: e.clientY };
    $("model").setPointerCapture(e.pointerId);
  });
  $("model").addEventListener("pointermove", (e) => {
    if (!drag) return;
    yaw += (e.clientX - drag.x) * 0.008;
    pitch = Math.max(-1.4, Math.min(1.4, pitch + (e.clientY - drag.y) * 0.008));
    drag = { x: e.clientX, y: e.clientY };
    render();
  });
  for (const event of ["pointerup", "pointercancel", "lostpointercapture"])
    $("model").addEventListener(event, () => {
      drag = null;
    });
  $("model").addEventListener("keydown", (e) => {
    if (
      ![
        "ArrowLeft",
        "ArrowRight",
        "ArrowUp",
        "ArrowDown",
        "+",
        "=",
        "-",
      ].includes(e.key)
    )
      return;
    e.preventDefault();
    if (e.key === "ArrowLeft") yaw -= 0.1;
    if (e.key === "ArrowRight") yaw += 0.1;
    if (e.key === "ArrowUp") pitch -= 0.1;
    if (e.key === "ArrowDown") pitch += 0.1;
    pitch = Math.max(-1.4, Math.min(1.4, pitch));
    if (e.key === "+" || e.key === "=") changeZoom(1.2);
    else if (e.key === "-") changeZoom(1 / 1.2);
    else render();
  });
  new ResizeObserver(render).observe($("plot"));

  function download(content, type, filename) {
    const url = URL.createObjectURL(new Blob([content], { type }));
    const a = document.createElement("a");
    a.href = url;
    a.download = filename;
    a.click();
    setTimeout(() => URL.revokeObjectURL(url), 1000);
    $("file-status").textContent = `Exported ${filename}`;
  }
  $("export-json").addEventListener("click", () => {
    if (!design) return;
    if (polynomial) {
      download(
        JSON.stringify(polynomial, null, 2),
        "application/json",
        "antenna-polynomial.json",
      );
      return;
    }
    const parameters = Object.fromEntries(
      known().map((k) => [k, isAngle(k) ? state[k] / RAD : state[k]]),
    );
    download(
      JSON.stringify(
        {
          format: "cassegrain-lab",
          version: 1,
          unit,
          angleUnit: "deg",
          sigma: state.sigma,
          group: state.group,
          option: state.option,
          parameters,
        },
        null,
        2,
      ),
      "application/json",
      "antenna-design.json",
    );
  });
  $("export-csv").addEventListener("click", () => {
    if (!design) return;
    const rows = [
      `main_r_${unit},main_z_${unit},sub_r_${unit},sub_z_${unit}`,
      ...M.profile(M.fromDesign(design), 401).map((p) =>
        Object.values(p)
          .map((n) => n.toPrecision(12))
          .join(","),
      ),
    ];
    download(rows.join("\n") + "\n", "text/csv", "antenna-profile.csv");
  });
  $("export-svg").addEventListener("click", () => {
    if (!design) return;
    download(
      new XMLSerializer().serializeToString(
        sectionSvg(design, 1100, 720, true),
      ),
      "image/svg+xml",
      "antenna-section.svg",
    );
  });
  $("import-json").addEventListener("click", () => $("import-file").click());
  $("import-file").addEventListener("change", async (e) => {
    const file = e.target.files[0];
    if (!file) return;
    try {
      if (file.size > 100000)
        throw new Error("Design files must be smaller than 100 KB.");
      const data = JSON.parse(await file.text());
      if (data.format === "cassegrain-polynomial") {
        applyPolynomial(data);
        $("file-status").textContent = `Opened ${file.name}`;
        return;
      }
      if (
        data.format !== "cassegrain-lab" ||
        data.version !== 1 ||
        data.angleUnit !== "deg" ||
        !Object.hasOwn(units, data.unit) ||
        !Object.hasOwn(G.inputs, data.group) ||
        !Number.isInteger(data.option) ||
        !G.inputs[data.group][data.option - 1] ||
        ![-1, 1].includes(data.sigma) ||
        !data.parameters ||
        typeof data.parameters !== "object"
      )
        throw new Error("Choose a version 1 Cassegrain Lab design file.");
      const next = {
        ...G.presets.cassegrain,
        sigma: data.sigma,
        group: data.group,
        option: data.option,
      };
      for (const key of Object.keys(G.labels))
        if (!isAngle(key) && Number.isFinite(next[key]))
          next[key] /= units[data.unit];
      for (const key of G.inputs[data.group][data.option - 1]) {
        if (
          typeof data.parameters[key] !== "number" ||
          !Number.isFinite(data.parameters[key])
        )
          throw new Error(`Invalid or missing ${key}.`);
        next[key] = data.parameters[key] * (isAngle(key) ? RAD : 1);
      }
      G.solve(next);
      state = next;
      polynomial = null;
      unit = data.unit;
      zoom = 1;
      setCustom();
      buildControls();
      update();
      $("file-status").textContent = `Opened ${file.name}`;
    } catch (error) {
      $("file-status").textContent = `Could not open design: ${error.message}`;
    } finally {
      e.target.value = "";
    }
  });
  function applyPolynomial(data) {
    const next = P.validate(data);
    P.scene(next);
    polynomial = next;
    unit = next.unit;
    state = { group: "poly", option: 1, sigma: -1 };
    zoom = 1;
    setCustom();
    buildControls();
    update();
  }
  window.addEventListener("antenna-polynomial-import", (e) =>
    applyPolynomial(e.detail),
  );
  buildControls();
  update();
})();

