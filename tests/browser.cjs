const { chromium } = require("playwright");
const assert = require("node:assert/strict");
const { spawn } = require("node:child_process");
const { mkdirSync, readFileSync } = require("node:fs");
const { pathToFileURL } = require("node:url");
const path = require("node:path");
const root = path.resolve(__dirname, "..");
const results = path.join(root, "test-results");
mkdirSync(results, { recursive: true });
(async () => {
  const server = spawn(
    process.execPath,
    [path.join(root, "scripts/serve.cjs")],
    { env: { ...process.env, PORT: "0" } },
  );
  let browser;
  try {
    const url = await new Promise((resolve, reject) => {
      server.stdout.on("data", (data) => {
        const match = String(data).match(/http:\/\/127\.0\.0\.1:\d+/);
        if (match) resolve(match[0]);
      });
      server.on("error", reject);
      server.on("exit", (code) => reject(new Error(`Server exited: ${code}`)));
    });
    const options = process.env.CHROME_PATH
      ? { executablePath: process.env.CHROME_PATH }
      : { channel: "chrome" };
    browser = await chromium.launch({ ...options, headless: true });
    const page = await browser.newPage({
      viewport: { width: 1440, height: 1100 },
      deviceScaleFactor: 1,
    });
    const errors = [],
      external = [];
    page.on("pageerror", (e) => errors.push(e.message));
    page.on("request", (r) => {
      if (
        !r.url().startsWith(url) &&
        !r.url().startsWith("file:") &&
        !r.url().startsWith("data:") &&
        !r.url().startsWith("blob:")
      )
        external.push(r.url());
    });
    await page.goto(url);
    await page.locator("#validation .valid").waitFor();
    assert.match(await page.locator("#metric-diameter").textContent(), /2.75/);
    await page.screenshot({
      path: path.join(results, "desktop.png"),
      fullPage: true,
    });
    for (const sigma of ["-1", "1"])
      for (const group of ["N", "B", "P"]) {
        await page.selectOption(
          "#preset",
          group === "N"
            ? sigma === "-1"
              ? "cassegrain"
              : "gregorian"
            : group === "B"
              ? "blockage"
              : "phase",
        );
        await page.selectOption("#antenna", sigma);
        for (let option = 1; option <= 7; option++) {
          await page.selectOption("#option", String(option));
          assert.equal(
            await page.locator("#validation .valid").count(),
            1,
            `Valid ${sigma} ${group}${option}`,
          );
          assert.equal(
            await page.locator("#routine").textContent(),
            `DRGEO${group}${option}`,
          );
        }
      }
    await page.selectOption("#preset", "cassegrain");
    const initial = await page.locator("#metric-diameter").textContent();
    await page.fill("#input-DM", "24");
    assert.notEqual(
      await page.locator("#metric-diameter").textContent(),
      initial,
    );
    await page.fill("#input-DM", "");
    assert.equal(await page.locator("#validation .invalid").count(), 1);
    assert.equal(await page.locator("#export-json").isDisabled(), true);
    assert.equal(await page.locator("#plot-error").isVisible(), true);
    assert.equal(await page.locator("#section path").count(), 0);
    await page.fill("#input-DM", "-22");
    assert.equal(
      await page.locator("#input-DM").getAttribute("aria-invalid"),
      "true",
    );
    await page.click("#reset");
    await page.selectOption("#unit", "mm");
    assert.equal(Number(await page.inputValue("#input-DM")), 22000);
    await page.selectOption("#unit", "in");
    assert.ok(
      Math.abs(Number(await page.inputValue("#input-DM")) - 22 / 0.0254) < 1e-7,
    );
    await page.selectOption("#unit", "m");
    assert.equal(Number(await page.inputValue("#input-DM")), 22);
    assert.ok((await page.locator("#section polyline").count()) > 0);
    await page.uncheck("#show-rays");
    assert.equal(await page.locator("#section polyline").count(), 0);
    await page.check("#show-rays");
    await page.click("#view-3d");
    assert.equal(await page.locator("#model").isVisible(), true);
    assert.equal(await page.locator("#section").isVisible(), false);
    const before = await page
      .locator("#model")
      .evaluate((canvas) => canvas.toDataURL());
    await page.locator("#model").focus();
    await page.keyboard.press("ArrowRight");
    const after = await page
      .locator("#model")
      .evaluate((canvas) => canvas.toDataURL());
    assert.notEqual(before, after);
    await page.click("#zoom-in");
    await page.click("#fit");
    await page.screenshot({
      path: path.join(results, "model-3d.png"),
      fullPage: true,
    });
    await page.click("#view-2d");
    async function download(id) {
      const event = page.waitForEvent("download");
      await page.click(id);
      const file = await event;
      const filename = path.join(results, file.suggestedFilename());
      await file.saveAs(filename);
      return filename;
    }
    const jsonPath = await download("#export-json");
    const data = JSON.parse(readFileSync(jsonPath, "utf8"));
    assert.equal(data.parameters.DM, 22);
    assert.equal(data.angleUnit, "deg");
    const csv = readFileSync(await download("#export-csv"), "utf8");
    assert.equal(csv.trim().split("\n").length, 402);
    assert.ok(csv.startsWith("main_r_m,main_z_m,sub_r_m,sub_z_m"));
    const svg = readFileSync(await download("#export-svg"), "utf8");
    assert.ok(svg.includes("http://www.w3.org/2000/svg"));
    assert.ok(!svg.includes("NaN"));
    await page.fill("#input-DM", "24");
    await page.setInputFiles("#import-file", jsonPath);
    await page.waitForFunction(
      () => document.querySelector("#input-DM").value === "22",
    );
    assert.match(await page.locator("#file-status").textContent(), /Opened/);
    await page.setInputFiles("#import-file", {
      name: "bad.json",
      mimeType: "application/json",
      buffer: Buffer.from('{"format":"bad"}'),
    });
    await page.waitForFunction(() =>
      document
        .querySelector("#file-status")
        .textContent.includes("Could not open"),
    );
    assert.equal(Number(await page.inputValue("#input-DM")), 22);
    await page.setViewportSize({ width: 390, height: 844 });
    await page.screenshot({
      path: path.join(results, "mobile.png"),
      fullPage: true,
    });
    assert.equal(
      await page.evaluate(
        () => document.documentElement.scrollWidth <= innerWidth,
      ),
      true,
      "No horizontal overflow on mobile",
    );
    await page.selectOption("#preset", "gregorian");
    assert.equal(await page.locator("#validation .valid").count(), 1);
    // Open geometry: all options, tilt-preserving polynomial round trip and RF.
    await page.setViewportSize({ width: 1440, height: 1100 });
    await page.selectOption("#antenna", "open");
    for (let option = 1; option <= 5; option++) {
      await page.selectOption("#option", String(option));
      assert.equal(
        await page.locator("#validation .valid").count(),
        1,
        `Open option ${option}`,
      );
      assert.equal(
        await page.locator("#routine").textContent(),
        `OCAGEO${option}`,
      );
    }
    assert.equal(await page.locator("#constraint").isDisabled(), true);
    const offset = Number(await page.inputValue("#input-TE"));
    await page.selectOption("#unit", "mm");
    await page.selectOption("#unit", "m");
    assert.ok(
      Math.abs(Number(await page.inputValue("#input-TE")) - offset) < 1e-9,
    );
    await page.fill("#frequency", "10");
    await page.waitForFunction(() =>
      document.querySelector("#peak-gain").textContent.includes("dBi"),
    );
    const gain10 = parseFloat(await page.locator("#peak-gain").textContent());
    const beam10 = parseFloat(await page.locator("#beamwidth").textContent());
    await page.fill("#frequency", "20");
    await page.waitForFunction(() =>
      document.querySelector("#peak-gain").textContent.includes("dBi"),
    );
    const gain20 = parseFloat(await page.locator("#peak-gain").textContent());
    assert.ok(Math.abs(gain20 - gain10 - 6.0206) < 0.01);
    assert.ok(
      parseFloat(await page.locator("#beamwidth").textContent()) <
        beam10 * 0.501,
    );
    const patternCsv = readFileSync(await download("#export-pattern"), "utf8");
    assert.ok(patternCsv.includes("angle_deg,relative_power_dB,gain_dBi"));
    assert.ok(!patternCsv.includes("NaN"));
    await page.fill("#frequency", "0");
    await page.waitForFunction(() =>
      document
        .querySelector("#pattern-status")
        .textContent.includes("Frequency must"),
    );
    assert.equal(await page.locator("#export-pattern").isDisabled(), true);
    assert.equal(await page.locator("#pattern-chart polyline").count(), 0);
    await page.fill("#frequency", "10");
    await page.waitForFunction(() =>
      document.querySelector("#peak-gain").textContent.includes("dBi"),
    );
    await page.selectOption("#pattern-scale", "relative");
    assert.ok((await page.locator("#pattern-chart polyline").count()) > 0);
    await page.selectOption("#poly-degree", "10");
    const polyPath = await download("#export-polynomial");
    const polynomial = JSON.parse(readFileSync(polyPath, "utf8"));
    assert.equal(polynomial.format, "cassegrain-polynomial");
    assert.ok(polynomial.main.apertureOffset > 0);
    assert.ok(polynomial.sub.axisAngleDeg > 90);
    assert.ok(polynomial.sub.fitError.max < 1e-7);
    const functions = readFileSync(await download("#export-functions"), "utf8");
    assert.ok(functions.includes("zLocal(u) ="));
    await page.locator("#plot").scrollIntoViewIfNeeded();
    await page.screenshot({
      path: path.join(results, "open-section.png"),
      fullPage: true,
    });
    await page.click("#view-3d");
    await page.screenshot({
      path: path.join(results, "open-3d.png"),
      fullPage: true,
    });
    await page.setInputFiles("#import-file", polyPath);
    await page.waitForFunction(
      () => document.querySelector("#routine").textContent === "POLYNOMIAL",
    );
    assert.equal(await page.locator("#show-rays").isDisabled(), true);
    assert.equal(
      await page.locator("#metric-magnification").textContent(),
      "—",
    );
    assert.equal(
      await page.locator("#polynomial-pattern-note").isVisible(),
      true,
    );
    await page.click("#view-2d");
    assert.equal(await page.locator("#section polyline").count(), 0);
    const importedCsv = readFileSync(await download("#export-csv"), "utf8");
    assert.ok(!importedCsv.includes("NaN"));
    await page.locator("#polynomial-editor summary").click();
    await page.click("#edit-current-polynomial");
    const edited = JSON.parse(await page.inputValue("#polynomial-json"));
    delete edited.sub.coefficients;
    edited.sub.expression = "20 - 0.2*u^2";
    await page.fill("#polynomial-json", JSON.stringify(edited));
    await page.click("#apply-polynomial");
    assert.match(
      await page.locator("#poly-import-status").textContent(),
      /applied/,
    );
    const saved = JSON.parse(
      readFileSync(await download("#export-json"), "utf8"),
    );
    assert.deepEqual(saved.sub.coefficients, [20, 0, -0.2]);
    await page.selectOption("#unit", "mm");
    const scaled = JSON.parse(
      readFileSync(await download("#export-json"), "utf8"),
    );
    assert.equal(scaled.sub.coefficients[0], 20000);
    await page.selectOption("#unit", "m");
    edited.sub.expression = "globalThis.alert(1)";
    await page.fill("#polynomial-json", JSON.stringify(edited));
    await page.click("#apply-polynomial");
    assert.match(
      await page.locator("#poly-import-status").textContent(),
      /Could not apply/,
    );
    assert.equal(await page.locator("#routine").textContent(), "POLYNOMIAL");
    await page.setViewportSize({ width: 390, height: 844 });
    assert.equal(
      await page.evaluate(
        () => document.documentElement.scrollWidth <= innerWidth,
      ),
      true,
      "Extended UI fits mobile width",
    );
    await page.screenshot({
      path: path.join(results, "extensions-mobile.png"),
      fullPage: true,
    });
    await page.goto(pathToFileURL(path.join(root, "index.html")).href);
    await page.locator("#validation .valid").waitFor();
    assert.match(await page.locator("#metric-diameter").textContent(), /2.75/);
    assert.deepEqual(errors, []);
    assert.deepEqual(external, []);
    await page.selectOption("#preset", "open2");
    await page.locator("#validation .valid").waitFor();
    assert.ok((await page.locator("#pattern-chart polyline").count()) > 0);
    console.log(
      "PASS: 42 symmetric and 5 open modes; frequency/patterns; polynomial expressions, tilt, exports/import, units, validation, mobile layout, and offline file:// use.",
    );
  } finally {
    if (browser) await browser.close();
    server.kill();
  }
})().catch((e) => {
  console.error(e);
  process.exitCode = 1;
});

