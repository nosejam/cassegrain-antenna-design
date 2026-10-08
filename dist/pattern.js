/* Scalar, circular aperture far-field model; flat phase and specified Gaussian
 * aperture illumination. NOT a full-wave or profile-to-field solver.
 * Fourier aperture relation: NRAO Essential Radio Astronomy, Ch. 3, eq. 3.97.
 * Bessel expansion: NIST DLMF 10.17.1/10.17.3. All lengths below are meters.
 */
(function (root) {
  "use strict";
  const C = 299792458;
  function j0(value) {
    const x = Math.abs(value);
    if (x < 12) {
      let term = 1,
        sum = 1;
      for (let k = 1; k < 100; k++) {
        term *= (-x * x) / (4 * k * k);
        sum += term;
        if (Math.abs(term) < 1e-16) break;
      }
      return sum;
    }
    let a = 1,
      p = 1,
      q = 0;
    for (let k = 1; k <= 20; k++) {
      a *= -((2 * k - 1) ** 2) / (8 * k * x);
      if (k % 2 === 0) p += (k % 4 === 0 ? 1 : -1) * a;
      else q += (k % 4 === 1 ? 1 : -1) * a;
    }
    return (
      Math.sqrt(2 / (Math.PI * x)) *
      (Math.cos(x - Math.PI / 4) * p - Math.sin(x - Math.PI / 4) * q)
    );
  }
  function calculate({
    diameter,
    obstructionRatio = 0,
    frequencyGHz = 10,
    edgeTaperDb = -10,
    efficiency = 0.7,
    span = 6,
  }) {
    if (!Number.isFinite(diameter) || diameter <= 0)
      throw new Error(
        "Pattern analysis requires a positive aperture diameter.",
      );
    if (
      !Number.isFinite(frequencyGHz) ||
      frequencyGHz <= 0 ||
      frequencyGHz > 10000
    )
      throw new Error(
        "Frequency must be greater than 0 and at most 10,000 GHz.",
      );
    if (!Number.isFinite(edgeTaperDb) || edgeTaperDb > 0 || edgeTaperDb < -60)
      throw new Error("Aperture edge taper must be from −60 to 0 dB.");
    if (!Number.isFinite(efficiency) || efficiency <= 0 || efficiency > 1)
      throw new Error(
        "Other efficiency must be greater than 0% and at most 100%.",
      );
    if (
      !Number.isFinite(obstructionRatio) ||
      obstructionRatio < 0 ||
      obstructionRatio >= 0.95
    )
      throw new Error(
        "Obstruction diameter ratio must be from 0 to less than 0.95.",
      );
    if (!Number.isFinite(span) || span < 1 || span > 12)
      throw new Error("Pattern span must be from 1 to 12 λ/D.");
    const wavelength = C / (frequencyGHz * 1e9),
      electricalDiameter = diameter / wavelength;
    if (electricalDiameter < 10)
      throw new Error(
        "This aperture approximation requires D ≥ 10 wavelengths. Increase frequency or aperture size.",
      );
    const taper = (edgeTaperDb * Math.LN10) / 20;
    const n = 384,
      dr = (1 - obstructionRatio) / n;
    const radii = [],
      weights = [];
    // Composite Simpson quadrature over the unblocked aperture radius.
    for (let i = 0; i <= n; i++) {
      const r = obstructionRatio + i * dr;
      radii.push(r);
      weights.push(
        ((2 * r * Math.exp(taper * r * r) * dr) / 3) *
          (i === 0 || i === n ? 1 : i % 2 ? 4 : 2),
      );
    }
    const integral = weights.reduce((a, b) => a + b, 0);
    // Reference power includes the entire incident aperture, including its blocked part.
    const incidentPower = taper === 0 ? 1 : Math.expm1(2 * taper) / (2 * taper);
    const apertureEfficiency = (integral * integral) / incidentPower;
    const peakGain =
      10 *
      Math.log10(
        efficiency * (Math.PI * electricalDiameter) ** 2 * apertureEfficiency,
      );
    const amplitude = (q) =>
      weights.reduce((sum, w, i) => sum + w * j0(q * radii[i]), 0) / integral;
    // Limit to the forward ±30° region; this is a main-beam/sidelobe estimate.
    const maxAngle = Math.min(Math.PI / 6, span / electricalDiameter),
      count = 801;
    const samples = Array.from({ length: count }, (_, i) => {
      const angle = maxAngle * (-1 + (2 * i) / (count - 1));
      const field = amplitude(Math.PI * electricalDiameter * Math.sin(angle));
      const relativeDb = 20 * Math.log10(Math.max(1e-12, Math.abs(field)));
      return {
        angleDeg: (angle * 180) / Math.PI,
        relativeDb,
        gainDbi: peakGain + relativeDb,
      };
    });
    let lo = 0,
      hi = 4;
    for (let i = 0; i < 60; i++) {
      const m = (lo + hi) / 2;
      if (amplitude(m) ** 2 > 0.5) lo = m;
      else hi = m;
    }
    const hpbwDeg =
      (2 * Math.asin((lo + hi) / 2 / (Math.PI * electricalDiameter)) * 180) /
      Math.PI;
    return {
      samples,
      wavelength,
      electricalDiameter,
      peakGain,
      hpbwDeg,
      apertureEfficiency,
      totalEfficiency: efficiency * apertureEfficiency,
      farField: (2 * diameter * diameter) / wavelength,
      maxAngleDeg: (maxAngle * 180) / Math.PI,
      obstructionRatio,
      frequencyGHz,
      edgeTaperDb,
      efficiency,
      amplitude,
    };
  }
  const api = { calculate, j0, C };
  if (typeof module !== "undefined" && module.exports) module.exports = api;
  else root.AntennaPattern = api;
})(typeof globalThis !== "undefined" ? globalThis : this);

