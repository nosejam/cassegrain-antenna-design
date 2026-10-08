// Compile the untouched routines in a temporary directory and compare every port.
// Requires gfortran, but is separate from the dependency-free JavaScript tests.
const { mkdtempSync, readFileSync, writeFileSync, rmSync } = require("node:fs");
const { tmpdir } = require("node:os");
const path = require("node:path");
const { execFileSync } = require("node:child_process");
const assert = require("node:assert/strict");
const G = require("../geometry.js");
const temp = mkdtempSync(path.join(tmpdir(), "cassegrain-fortran-"));
const fields = ["DM", "FM", "LM", "DS", "LS", "TE", "DF", "DPC", "A", "FS"];
const calls = {
  N: [
    "DM,LM,LS,TE,FM,DS,A,FS",
    "DM,FM,LM,TE,DS,LS,A,FS",
    "DM,FM,LS,TE,LM,DS,A,FS",
    "FM,DS,LS,TE,DM,LM,A,FS",
    "LM,DS,LS,TE,DM,FM,A,FS",
    "DM,FM,DS,TE,LM,LS,A,FS",
    "DM,DS,LS,TE,FM,LM,A,FS",
  ],
  B: [
    "DM,FM,LM,DF,DS,LS,A,FS,TE",
    "DM,FM,TE,DF,LM,DS,LS,A,FS",
    "DM,FM,DS,DF,LM,LS,A,FS,TE",
    "DM,LM,DS,DF,FM,LS,A,FS,TE",
    "DM,DS,TE,DF,FM,LM,LS,A,FS",
    "DM,LM,TE,DF,FM,DS,LS,A,FS",
    "DM,LS,TE,DF,FM,LM,DS,A,FS",
  ],
};
calls.P = calls.B;
const cases = [];
for (const preset of [
  ...Object.values(G.presets).filter((p) => p.group !== "O"),
  {
    ...G.presets.blockage,
    sigma: 1,
    TE: (7.96175 * Math.PI) / 180,
    LS: 4.64675,
  },
  { ...G.presets.phase, sigma: 1 },
]) {
  for (let option = 1; option <= 7; option++) cases.push({ ...preset, option });
}
for (const sigma of [-1, 1])
  for (const group of ["N", "B", "P"])
    for (const scale of [0.01, 3.6, 1000]) {
      const preset =
        group === "N"
          ? G.presets[sigma === -1 ? "cassegrain" : "gregorian"]
          : G.presets[group === "B" ? "blockage" : "phase"];
      const base = G.solve({ ...preset, sigma });
      for (const key of fields)
        if (key !== "TE" && Number.isFinite(base[key])) base[key] *= scale;
      for (let option = 1; option <= 7; option++)
        cases.push({ ...base, option });
    }
try {
  const source = readFileSync(path.join(__dirname, "../GRANET.FOR"), "utf8");
  writeFileSync(
    path.join(temp, "routines.f"),
    source.slice(source.indexOf("      SUBROUTINE DRGEON1")),
  );
  const driver = ["program verify", `real :: SIGMA,${fields.join(",")}`];
  cases.forEach((p, i) => {
    driver.push(`SIGMA=${p.sigma}.0`);
    for (const key of fields)
      driver.push(`${key}=${Number(p[key] || 0).toExponential(17)}`);
    driver.push(
      `call DRGEO${p.group}${p.option}(SIGMA,${p.group === "P" ? "DPC," : ""}${calls[p.group][p.option - 1]})`,
    );
    driver.push(`write(*,'(I5,10ES26.16)') ${i},${fields.join(",")}`);
  });
  driver.push("end program");
  writeFileSync(path.join(temp, "driver.f90"), driver.join("\n"));
  execFileSync(
    "gfortran",
    [
      "-std=legacy",
      "-fdefault-real-8",
      "-fdefault-double-8",
      "-ffixed-line-length-none",
      "-ffree-line-length-none",
      path.join(temp, "driver.f90"),
      path.join(temp, "routines.f"),
      "-o",
      path.join(temp, "verify"),
    ],
    { stdio: "pipe" },
  );
  const rows = execFileSync(path.join(temp, "verify"), { encoding: "utf8" })
    .trim()
    .split("\n");
  assert.equal(rows.length, cases.length);
  let largestRelative = 0;
  for (const line of rows) {
    const [index, ...expected] = line.trim().split(/\s+/).map(Number);
    const p = cases[index],
      result = G.raw(p);
    fields.forEach((key, i) => {
      const difference =
        Math.abs(result[key] - expected[i]) /
        Math.max(1e-10, Math.abs(expected[i]));
      largestRelative = Math.max(largestRelative, difference);
      assert.ok(
        Number.isFinite(result[key]) && difference < 2e-8,
        `${p.sigma} ${p.group}${p.option} ${key}: JS ${result[key]} vs Fortran ${expected[i]}`,
      );
    });
  }
  console.log(
    `PASS: ${cases.length} cases, all 21 routines, both antenna types, and multiple scales.`,
  );
  console.log(
    `Compared against gfortran with 64-bit REAL. Maximum relative difference: ${largestRelative.toExponential(3)}.`,
  );
} finally {
  rmSync(temp, { recursive: true, force: true });
}

