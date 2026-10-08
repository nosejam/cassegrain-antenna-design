# Cassegrain Lab

A local HTML/JavaScript workbench for symmetric Cassegrain, Gregorian, and open-Cassegrain antenna geometry, with estimated gain patterns and polynomial profile interchange. Uses the equations in `GRANET.FOR` and `GRANEOC.FOR`. The original Fortran files are preserved.

## Run

Open **index.html** directly in a modern browser. Everything runs offline: no server, account, build, external fonts, or runtime dependencies are needed.

Alternatively, with Node.js 18 or newer:

```sh
npm start
```

Open http://127.0.0.1:8000. Set `PORT` to use another port. The server binds only to loopback and serves only the application assets and its Fortran reference.

## Design workflow

1. Choose an original example or an antenna type.
2. For symmetric designs select free geometry, minimum blockage, or blockage with a recessed feed phase center. Open-Cassegrain has its own geometry options.
3. Select one of seven symmetric or five open-Cassegrain combinations of known parameters and edit the values. Changing combinations carries the solved dimensions forward.
4. Examine the equal-scale cross-section, ray construction, and calculated dimensions. Switch to 3D and drag or use arrow keys to rotate; use the zoom and Fit controls.
5. Save/open a design as JSON, export paired reflector profiles as CSV, or download the cross-section as a standalone SVG.
6. Choose frequency, aperture edge taper, and other efficiency in the gain-pattern panel. Export the sampled pattern as CSV.
7. Use Polynomial interchange to export fitted functions, download their JSON definition, or import/edit a pair of arbitrary radial polynomials.

Length units convert the existing physical design between meters, centimeters, millimeters, and inches. The source examples have no specified physical unit; this application initially interprets their lengths as meters. User-facing angles and saved-file angles are degrees; the calculation API uses radians. Presets always load those original example values interpreted in meters, converted to the selected display unit. Inputs update immediately; invalid designs clear the plot and outputs and disable exports.

## Implemented equations

All **21 routines in GRANET.FOR** are ported, with both `SIGMA = -1` (Cassegrain) and `SIGMA = +1` (Gregorian):

| Constraint | Source routines | Parameters |
| --- | --- | --- |
| Free geometry | `DRGEON1`–`DRGEON7` | Four prescribed geometric values |
| Minimum blockage | `DRGEOB1`–`DRGEOB7` | Four values including feed diameter `DF` |
| Blockage with recessed phase center | `DRGEOP1`–`DRGEOP7` | Four values plus phase-center recess `DPC` |
| Open-Cassegrain | `OCAGEO1`–`OCAGEO5` | Four values from DM, FM, DS, THO, TE, DISTM |

Equation numbers and routine names are preserved in `geometry.js`. Equations are credited in the source to Christophe Granet, *IEEE Antennas and Propagation Magazine*, April and June 1998; the Fortran code is credited to T. A. Milligan. No license for the supplied Fortran was included; this project does not assert a new license over it.

The other source families are **not ported**: `GRANETOC.FOR` (classical offset), `GRANETI.FOR` (its offset configuration), `GRANETD.FOR` (Dragonian), `GRANET1.FOR` (displaced-axis), and `GRANETS.FOR` (Schwarzschild).

### Open-Cassegrain geometry and source discrepancy

The open main reflector is a circular aperture cut from the parent paraboloid, offset by H. The secondary's local origin is the main focus `(0, FM)` and its axis is rotated by `180° − THO` from global +z toward +x. Its local sag is `c − a sqrt(1 + r²/(c² − a²))`. The feed is `2c` along that axis. The 3D main aperture is offset, not revolved about its aperture center. All five options use the source geometric equations; bracketed double-precision root solving replaces the source's coarse scans and limited false-position iterations. The supported offset angle is between 0° and 90°, with a positive main-surface-to-feed distance. Option 1 selects the larger secondary half-angle root, as the source does.

**The source's `ASR` does not equal its own `FS/EC`.** Algebraically its cosine denominator yields `ASR = (FS/EC) tan(TE)`. For the 100-unit example the legacy ASR is about 4.0605, whereas c/e is about 16.2859. The application retains the original ASR in the results and reference comparison, but uses **a = c/e** for the actual hyperbola, ray construction, and polynomial exports. This correction is independently checked using both reflection laws, rim mapping, and equal optical path length. `GRANEOC.FOR` itself is unchanged. These designs lie on the theoretical zero-clearance boundary; hardware needs margin.

The open-Cassegrain paper is listed by [Granet's publication page](https://www.lyrebirdantennas.com/publications/christopheGranet.html) as *IEEE Antennas and Propagation Magazine*, 54(2), April 2012, pp. 136–147. The local Fortran, not a downloaded paper, is the equation source for this port.

## Geometry and limitations

The main vertex is the origin, the aperture faces +z, the feed phase center is at `z = LM`, and the main focus is at `z = FM`. `LM` is signed. The conic center is at `LM + FS`, with `FS` the half interfocal distance (often written c), and `A` the conic semi-axis a. The secondary vertex is at `LM + LS`.

```text
Main parabola:     z = r² / (4 FM)
Secondary conic:   z = LM + c + a sqrt(1 − sigma r² / b²)
                  b² = sigma (a² − c²)
Eccentricity:      e = c/a
Magnification:    M = (a+c) / |a−c|
Effective focal:   Feff = M FM
Projected area:    blockage = (DS/DM)²
```

Rays intersect the actual conic and parabola; they are ideal optical construction rays, including rays that central hardware could obscure. The view has no horn model, support struts, manufactured hole, or occlusion solver. In blockage modes the feed aperture is indicated in the cross-section. The 3D view is an orthographic wireframe of surfaces of revolution, not a manufactured assembly.

The UI supports the positive-a, positive-c, upper conic branch with the secondary in front of the main rim. Invalid/degenerate conics, complex roots, and inconsistent rim rays are rejected. Negative LM is allowed and flagged because it requires a central opening. Near-singular configurations can be sensitive to small changes. Original quadratic root choices are retained; the solver does not search alternative roots or perform optimization.

The area blockage metric is **not RF efficiency**. The separate pattern model below estimates scalar aperture diffraction, gain, and beamwidth. It does not model a horn, support scattering, cross-polarization, surface tolerances, or full-wave interactions.

## Estimated gain patterns

The pattern model implements a radial Fourier/Hankel integral of a **specified flat-phase circular aperture field**, following the aperture-field relationship in [NRAO Essential Radio Astronomy, Chapter 3](https://www.cv.nrao.edu/~sransom/web/Ch3.html). Frequency is in GHz; geometry is converted to meters before computing wavelength. Aperture edge taper is an amplitude ratio expressed in dB; 0 dB means uniform illumination. Other efficiency is a separate multiplicative loss factor, not total aperture efficiency.

For normalized aperture radius t, central obstruction ratio ε, and aperture field `A(t) = exp(ln(10) × edgeTaperDb × t²/20)`:

```text
I(q) = 2 ∫[ε,1] A(t) J0(qt) t dt
q = π D sin(theta) / wavelength
Pincident = 2 ∫[0,1] A(t)² t dt
G(theta) = etaOther × (π D / wavelength)² × |I(q)|² / Pincident
relativePower(theta) = |I(q) / I(0)|²
```

The power reference includes illumination over the blocked portion, so obstruction incurs both power loss and a change in pattern shape. The model integrates with Simpson quadrature; J0 uses its series and [NIST DLMF asymptotic expansion](https://dlmf.nist.gov/10.17). Uniform clear-aperture behavior is checked against the Airy pattern. Half-power beamwidth is solved independently of the chart sampling. The CSV contains the sampled angles, relative power, gain, and model inputs.

Symmetric designs assume a central obstruction of diameter DS. Open-Cassegrain assumes a clear circular aperture, using its projected main diameter. This idealized illumination gives a common scalar cut; it does **not** predict distinct E/H cuts, offset asymmetry, cross-polarization, feed spillover, or detailed illumination from reflector mapping. Other efficiency defaults to 70% and should be chosen for the intended hardware. The model requires D ≥ 10 wavelengths and plots only the forward region up to ±30°.

**For imported polynomials, only aperture diameter and specified obstruction affect the pattern.** Arbitrary profile shapes are not traced to derive aperture phase, illumination, aberrations, or defocus. Editing profile coefficients alone therefore does not change the assumed flat-phase pattern. A physical-optics or full-wave solver would be needed to establish the performance of a general shaped design.

## Polynomial functions: export and import

Use the fit-degree selector (2–12), then download **Polynomial JSON** for interchange or **Functions TXT** for readable formulas, coordinates, and sampled fit residuals. The main parabola is exported analytically as a quadratic. Hyperbolic and elliptical secondaries cannot be represented exactly by finite polynomials: their exports use Chebyshev interpolation, converted to ascending power coefficients, over the stated radial domain. Maximum and RMS residuals are measured on 2,001 samples, not rigorous continuous error bounds. Imported coefficients are preserved exactly rather than refitted.

Each surface is `zLocal = sum(coefficients[i] * u^i)`, with `u = (r - rOrigin)/rScale` and `r = hypot(xLocal, yLocal)`. Coefficients and sag have the file's length unit; u is dimensionless. A circular local aperture is centered at `(apertureOffset, 0)` with radius `apertureRadius`. Global placement is:

```text
xGlobal = origin[0] + xLocal*cos(angle) + zLocal*sin(angle)
yGlobal = yLocal
zGlobal = origin[1] - xLocal*sin(angle) + zLocal*cos(angle)
angle = axisAngleDeg in degrees
```

This preserves the open-Cassegrain main offset and secondary tilt. A profile CSV contains corresponding samples of the two **global x-z sections**, despite the legacy `main_r`/`sub_r` header names; those columns are signed global x coordinates, not always each surface's local radius. Use the polynomial functions and placement above when generating 3D surfaces.

Open **Import or edit polynomial functions → Load current profiles into editor** for a complete editable example. For either surface, replace `coefficients` with `expression` to enter a function such as `"6.54 + 0.22*u^2"`. Do not supply both. Set `rOrigin=0` and `rScale=1` when u should equal the physical radius. Expressions support numbers, scientific notation, u, parentheses, +, −, explicit multiplication, division by nonzero constants, and integer powers 0–12; they are parsed as polynomials without JavaScript evaluation.

Example complete file (illustrative profiles, **not an optically validated design**):

```json
{
  "format": "cassegrain-polynomial",
  "version": 1,
  "unit": "m",
  "name": "My polynomial antenna",
  "feed": [0, 1.4542],
  "obstructionRatio": 0.125,
  "main": {
    "expression": "u^2 / (4 * 7.379)",
    "rOrigin": 0, "rScale": 1, "rMin": 0, "rMax": 11,
    "apertureRadius": 11, "apertureOffset": 0,
    "origin": [0, 0], "axisAngleDeg": 0
  },
  "sub": {
    "expression": "6.541 + 0.249*u^2 - 0.015*u^4",
    "rOrigin": 0, "rScale": 1, "rMin": 0, "rMax": 1.375,
    "apertureRadius": 1.375, "apertureOffset": 0,
    "origin": [0, 0], "axisAngleDeg": 0
  }
}
```

Apply the editor or open the file with either polynomial import or the existing **Open design** button. The main axis currently must face global +z; secondary rotation and both aperture offsets are supported. Geometry-only checks enforce finite coefficients, supported degree, and full radial-domain coverage. They do not establish reflection behavior, clearances, or collimation. Conic-specific dimensions and ideal rays are disabled for arbitrary imported polynomials. Changing units scales coefficients, domains, origins, and feed position consistently. Gain controls are session settings; they are recorded in pattern CSV exports, not geometry JSON files.

## Verification

The equation tests need only Node.js:

```sh
npm test
```

71 tests cover all 42 symmetric routine/type combinations, all five open options for both examples, conic intersections, specular reflection, equal optical path length, circular offset-rim mapping, unit scaling, polynomial parsing and coordinate round trips, invalid inputs, Airy-pattern checks, and gain/frequency behavior.

With `gfortran` installed:

```sh
npm run test:fortran
```

This extracts the untouched routines into temporary builds with 64-bit REAL and compares 168 symmetric cases plus 10 open-Cassegrain cases. Symmetric results agree to approximately 4.1e-15 relative error in the checked cases. Open-source output retains its original `XACC=1e-5` and 30-iteration limit, so comparisons allow its residual root error (largest observed relative difference about 8.95e-4, in option 5). Independent optical invariants and precise round trips test the new solver beyond that loose legacy tolerance. The inconsistent legacy ASR is compared separately; it is not used to generate the corrected surfaces. Temporary compiler artifacts are removed afterward.

For browser verification, install the development-only dependency and use an installed Google Chrome:

```sh
npm ci
npm run test:browser
```

Set `CHROME_PATH` if Chrome is not in its standard location. The test starts its own temporary local server, exercises the UI and exports, checks mobile overflow and direct `file://` operation, and saves screenshots and export samples in ignored `test-results/`.

## Files

- `index.html`, `styles.css`, `app.js`: interface and visualization.
- `geometry.js`: independent solver; accessible as `window.AntennaGeometry` in the browser and `require('./geometry.js')` in Node.
- `open-cassegrain.js`: open geometry solver and ray construction.
- `antenna-model.js`, `visualization.js`: placed radial surfaces and common 2D/3D rendering.
- `polynomials.js`: interpolation, expression parsing, validation, and interchange.
- `pattern.js`, `analysis-ui.js`: scalar pattern calculation and analysis panels.
- `scripts/serve.cjs`: optional local preview server.
- `scripts/verify-fortran.cjs`: compiled-source comparison harness.
- `tests/`: equation and browser checks.

`AntennaGeometry.solve()` dispatches symmetric or open geometry. Its `raw()`, `traceRay()`, and `profile()` retain their symmetric-only API. For all supported designs, use `AntennaModel.fromDesign()` and `AntennaModel.profile()` for placed surfaces and global profiles. Geometry API angles are radians; polynomial JSON angles are explicitly degrees. Lengths must share one unit. `AntennaPattern.calculate()` accepts aperture diameter in meters and frequency in GHz.

