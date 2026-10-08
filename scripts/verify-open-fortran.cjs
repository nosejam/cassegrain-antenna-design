const { mkdtempSync, readFileSync, writeFileSync, rmSync } = require("node:fs");
const { tmpdir } = require("node:os");
const path = require("node:path");
const { execFileSync } = require("node:child_process");
const assert = require("node:assert/strict");
const O = require("../open-cassegrain");
const temp = mkdtempSync(path.join(tmpdir(), "open-cassegrain-fortran-"));
try {
  const source = readFileSync(path.join(__dirname, "../GRANEOC.FOR"), "utf8");
  writeFileSync(
    path.join(temp, "routines.f"),
    source.slice(source.indexOf("      SUBROUTINE OCAGEO1")),
  );
  const cases = [];
  for (const seed of [
    { DM: 100, FM: 71.0844, THO: 53.931, DS: 30, TE: 14, DISTM: 4 },
    { DM: 50, FM: 32.5142, THO: 56.6898, DS: 15, TE: 16, DISTM: 4 },
  ])
    for (let option = 1; option <= 5; option++)
      cases.push({
        ...seed,
        THO: (seed.THO * Math.PI) / 180,
        TE: (seed.TE * Math.PI) / 180,
        option,
      });
  const fields = [
    "DM",
    "FOCAL",
    "THO",
    "DS",
    "ASR",
    "FS",
    "THMR",
    "EC",
    "THE",
    "DISTM",
    "THEM",
  ];
  const jsFields = [
    "DM",
    "FM",
    "THO",
    "DS",
    "ASR",
    "FS",
    "THMR",
    "EC",
    "TE",
    "DISTM",
    "THEM",
  ];
  const driver = ["program verify", `real :: ${fields.join(",")}`];
  cases.forEach((p, i) => {
    fields.forEach((name, k) =>
      driver.push(`${name}=${Number(p[jsFields[k]] || 0).toExponential(17)}`),
    );
    driver.push(
      `call OCAGEO${p.option}(${fields.join(",")})`,
      `write(*,'(I5,11ES26.16)') ${i},${fields.join(",")}`,
    );
  });
  driver.push("end program");
  writeFileSync(path.join(temp, "driver.f90"), driver.join("\n"));
  execFileSync("gfortran", [
    "-w",
    "-std=legacy",
    "-fdefault-real-8",
    "-fdefault-double-8",
    "-ffixed-line-length-none",
    "-ffree-line-length-none",
    path.join(temp, "driver.f90"),
    path.join(temp, "routines.f"),
    "-o",
    path.join(temp, "verify"),
  ]);
  const rows = execFileSync(path.join(temp, "verify"), {
    encoding: "utf8",
    timeout: 10000,
  })
    .trim()
    .split("\n");
  assert.equal(rows.length, cases.length);
  let maxRelative = 0;
  rows.forEach((row) => {
    const [i, ...values] = row.trim().split(/\s+/).map(Number),
      p = cases[i],
      d = O.solve(p);
    jsFields.forEach((key, k) => {
      const rel =
        Math.abs(d[key] - values[k]) / Math.max(1, Math.abs(values[k]));
      maxRelative = Math.max(maxRelative, rel);
      // The untouched Fortran uses XACC=1e-5 rad and only 30 false-position
      // iterations. OCAGEO5 is particularly ill-conditioned; it is not an exact oracle.
      assert.ok(
        rel < (p.option === 5 ? 0.003 : 0.0005),
        `OCAGEO${p.option} ${key}: JS ${d[key]} vs legacy ${values[k]}`,
      );
    });
  });
  console.log(
    `PASS: all 5 open-Cassegrain routines, both original examples (${cases.length} cases).`,
  );
  console.log(
    `Maximum relative difference ${maxRelative.toExponential(3)}; legacy root tolerance retained. ASR compared separately from corrected a=c/e.`,
  );
} finally {
  rmSync(temp, { recursive: true, force: true });
}

