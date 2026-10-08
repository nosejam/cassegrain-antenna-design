(function (root) {
  "use strict";
  const M = root.AntennaModel,
    ns = "http://www.w3.org/2000/svg";
  function el(tag, attributes = {}, text) {
    const e = document.createElementNS(ns, tag);
    Object.entries(attributes).forEach(([k, v]) => e.setAttribute(k, v));
    if (text !== undefined) e.textContent = text;
    return e;
  }
  const fmt = (n) => Number(n.toPrecision(5)).toString();
  function bounds(scene) {
    const points = [
      ...M.section(scene.main),
      ...M.section(scene.sub),
      [scene.feed[0], 0, scene.feed[1]],
    ];
    if (scene.focus) points.push([scene.focus[0], 0, scene.focus[1]]);
    return {
      xmin: Math.min(...points.map((p) => p[0])),
      xmax: Math.max(...points.map((p) => p[0])),
      zmin: Math.min(...points.map((p) => p[2])),
      zmax: Math.max(...points.map((p) => p[2])),
    };
  }
  function section(
    scene,
    {
      width = 900,
      height = 560,
      zoom = 1,
      rays = true,
      dimensions = true,
      unit = "m",
      exported = false,
    } = {},
  ) {
    const svg = el("svg", {
      xmlns: ns,
      viewBox: `0 0 ${width} ${height}`,
      role: "img",
    });
    svg.append(
      el("title", { id: "plot-title" }, `${scene.name} cross-section`),
      el(
        "desc",
        { id: "plot-description" },
        `Equal scale in ${unit}. Main and secondary profiles in the global x-z plane.`,
      ),
    );
    svg.append(el("rect", { width, height, fill: "#14212c" }));
    const b = bounds(scene),
      D = scene.apertureDiameter;
    const endZ = b.zmax + D * 0.2,
      lowZ = b.zmin - D * 0.14;
    const centerZ = (endZ + lowZ) / 2,
      centerX = (b.xmin + b.xmax) / 2;
    const scale =
      Math.min(
        (width - 80) / (endZ - lowZ),
        (height - 110) / ((b.xmax - b.xmin) * 1.1),
      ) * (exported ? 1 : zoom);
    const x = (z) => width / 2 + (z - centerZ) * scale,
      y = (r) => height / 2 - (r - centerX) * scale;
    const line = (z1, r1, z2, r2, attributes = {}) =>
      svg.append(
        el("line", {
          x1: x(z1),
          y1: y(r1),
          x2: x(z2),
          y2: y(r2),
          stroke: "#536a74",
          "stroke-width": 1,
          ...attributes,
        }),
      );
    const text = (z, r, t, attributes = {}) =>
      svg.append(
        el(
          "text",
          {
            x: x(z),
            y: y(r),
            fill: "#a6b8bf",
            "font-size": 10,
            "font-family": "Consolas,monospace",
            ...attributes,
          },
          t,
        ),
      );
    const rawStep = Math.max(D, b.xmax - b.xmin, b.zmax - b.zmin) / 8,
      p = 10 ** Math.floor(Math.log10(rawStep));
    const step = [1, 2, 5, 10].map((n) => n * p).find((n) => n >= rawStep);
    const left = centerZ - width / (2 * scale),
      right = centerZ + width / (2 * scale),
      bottom = centerX - height / (2 * scale),
      top = centerX + height / (2 * scale);
    for (
      let z = Math.ceil(left / step) * step, i = 0;
      z < right && i < 150;
      z += step, i++
    )
      line(z, bottom, z, top, { stroke: "#253743", "stroke-width": 0.6 });
    for (
      let r = Math.ceil(bottom / step) * step, i = 0;
      r < top && i < 150;
      r += step, i++
    )
      line(left, r, right, r, { stroke: "#253743", "stroke-width": 0.6 });
    line(left, 0, right, 0, { "stroke-dasharray": "5 6", opacity: 0.7 });
    if (rays)
      for (const ray of scene.rays) {
        const points = [
          ray.feed,
          ray.sub,
          ray.main,
          { r: ray.main.r, z: endZ },
        ];
        svg.append(
          el("polyline", {
            points: points.map((p) => `${x(p.z)},${y(p.r)}`).join(" "),
            fill: "none",
            stroke: "#d3be7e",
            "stroke-width": 0.9,
            opacity: 0.48,
          }),
        );
        if (scene.focus)
          line(ray.sub.z, ray.sub.r, scene.focus[1], scene.focus[0], {
            "stroke-dasharray": "4 5",
            opacity: 0.2,
          });
        line(
          endZ - 7 / scale,
          ray.main.r - 3 / scale,
          endZ - 2 / scale,
          ray.main.r,
          { stroke: "#d3be7e", opacity: 0.7 },
        );
        line(
          endZ - 7 / scale,
          ray.main.r + 3 / scale,
          endZ - 2 / scale,
          ray.main.r,
          { stroke: "#d3be7e", opacity: 0.7 },
        );
      }
    for (const [surface, color] of [
      [scene.main, "#ffae75"],
      [scene.sub, "#77d4dc"],
    ]) {
      const points = M.section(surface);
      svg.append(
        el("path", {
          d: points
            .map((p, i) => `${i ? "L" : "M"} ${x(p[2])} ${y(p[0])}`)
            .join(" "),
          fill: "none",
          stroke: color,
          "stroke-width": 3,
          "stroke-linecap": "round",
        }),
      );
      if (dimensions) {
        const last = points.at(-1);
        text(
          last[2] + 6 / scale,
          last[0] + 13 / scale,
          `${surface.name.toUpperCase()} · Ø ${fmt(surface.radius * 2)} ${unit}`,
          { fill: color, "font-size": 9 },
        );
      }
    }
    for (const [point, label, color] of [
      [scene.feed, "Feed", "#dbe5d8"],
      [scene.focus, "F", "#9eafbb"],
    ])
      if (point) {
        svg.append(
          el("circle", {
            cx: x(point[1]),
            cy: y(point[0]),
            r: label === "Feed" ? 4 : 3,
            fill: "#14212c",
            stroke: color,
            "stroke-width": 1.7,
          }),
        );
        text(point[1], point[0] - 16 / scale, label, {
          "text-anchor": "middle",
          fill: color,
        });
      }
    if (scene.feedAperture) {
      const f = scene.feedAperture;
      line(f.z, f.x - f.radius, f.z, f.x + f.radius, {
        stroke: "#bacdb7",
        "stroke-width": 2,
      });
    }
    if (dimensions) {
      const a = M.section(scene.main, 2),
        z = lowZ + D * 0.04;
      line(z, a[0][0], z, a[1][0]);
      for (const v of a) {
        line(z - 4 / scale, v[0], v[2], v[0], { opacity: 0.5 });
        line(z - 4 / scale, v[0], z + 4 / scale, v[0]);
      }
      const yy = y((a[0][0] + a[1][0]) / 2),
        xx = x(z) - 10;
      svg.append(
        el(
          "text",
          {
            x: xx,
            y: yy,
            fill: "#a6b8bf",
            "text-anchor": "middle",
            "font-size": 10,
            "font-family": "monospace",
            transform: `rotate(-90 ${xx} ${yy})`,
          },
          `DM ${fmt(D)} ${unit}`,
        ),
      );
    }
    if (exported) {
      svg.append(
        el(
          "text",
          {
            x: 20,
            y: 25,
            fill: "#becdd0",
            "font-family": "sans-serif",
            "font-size": 12,
          },
          `${scene.name} · global x-z section · ${unit}`,
        ),
      );
      svg.append(
        el(
          "text",
          {
            x: 20,
            y: height - 18,
            fill: "#8fa3ad",
            "font-family": "sans-serif",
            "font-size": 10,
          },
          scene.kind === "polynomial"
            ? "Imported polynomial surfaces · optical performance not inferred from shape"
            : "Ideal optical construction · equal scale · supports and diffraction not shown",
        ),
      );
    }
    return svg;
  }
  function model(
    canvas,
    scene,
    {
      width,
      height,
      zoom = 1,
      yaw = 0.9,
      pitch = 0.32,
      rays = true,
      dimensions = true,
      unit = "m",
    },
  ) {
    const ratio = Math.min(devicePixelRatio || 1, 2);
    canvas.width = Math.round(width * ratio);
    canvas.height = Math.round(height * ratio);
    const ctx = canvas.getContext("2d");
    ctx.scale(ratio, ratio);
    const b = bounds(scene),
      cx = (b.xmin + b.xmax) / 2,
      cz = (b.zmin + b.zmax) / 2;
    const extent = Math.max(
        b.xmax - b.xmin,
        b.zmax - b.zmin,
        scene.apertureDiameter,
      ),
      scale = (Math.min(width - 90, height - 110) / extent) * zoom;
    function project(p) {
      const xx = p[0] - cx,
        zz = p[2] - cz,
        u = xx * Math.cos(yaw) + zz * Math.sin(yaw),
        depth = -xx * Math.sin(yaw) + zz * Math.cos(yaw);
      return [
        width / 2 + u * scale,
        height / 2 - (p[1] * Math.cos(pitch) - depth * Math.sin(pitch)) * scale,
      ];
    }
    function path(points, color, thickness = 1, opacity = 1, dash = false) {
      ctx.beginPath();
      points.forEach((p, i) => {
        const [x, y] = project(p);
        if (i) ctx.lineTo(x, y);
        else ctx.moveTo(x, y);
      });
      ctx.strokeStyle = color;
      ctx.lineWidth = thickness;
      ctx.globalAlpha = opacity;
      ctx.setLineDash(dash ? [4, 5] : []);
      ctx.stroke();
      ctx.setLineDash([]);
      ctx.globalAlpha = 1;
    }
    for (let i = -5; i <= 5; i++) {
      const q = (i * extent) / 10,
        y = -scene.apertureDiameter * 0.56;
      path(
        [
          [cx - extent / 2, y, cz + q],
          [cx + extent / 2, y, cz + q],
        ],
        "#3c5362",
        0.5,
        0.35,
      );
      path(
        [
          [cx + q, y, cz - extent / 2],
          [cx + q, y, cz + extent / 2],
        ],
        "#3c5362",
        0.5,
        0.35,
      );
    }
    for (const [s, color] of [
      [scene.main, "#ffae75"],
      [scene.sub, "#77d4dc"],
    ]) {
      for (let ring = 1; ring <= 9; ring++) {
        const r = (s.radius * ring) / 9;
        path(
          Array.from({ length: 97 }, (_, i) =>
            M.point(
              s,
              s.offset + r * Math.cos((i * Math.PI) / 48),
              r * Math.sin((i * Math.PI) / 48),
            ),
          ),
          color,
          ring === 9 ? 1.8 : 0.7,
          ring === 9 ? 1 : 0.34,
        );
      }
      for (let a = 0; a < 24; a++) {
        const phi = (a * Math.PI) / 12;
        path(
          Array.from({ length: 45 }, (_, i) => {
            const r = (s.radius * i) / 44;
            return M.point(s, s.offset + r * Math.cos(phi), r * Math.sin(phi));
          }),
          color,
          0.7,
          0.38,
        );
      }
    }
    if (rays)
      for (const r of scene.rays)
        path(
          [
            r.feed,
            r.sub,
            r.main,
            { r: r.main.r, z: b.zmax + scene.apertureDiameter * 0.16 },
          ].map((p) => [p.r, 0, p.z]),
          "#d3be7e",
          1,
          0.5,
        );
    for (const [p, label, color] of [
      [scene.feed, "Feed", "#dbe5d8"],
      [scene.focus, "F", "#97aab6"],
    ])
      if (p) {
        const [x, y] = project([p[0], 0, p[1]]);
        ctx.fillStyle = color;
        ctx.beginPath();
        ctx.arc(x, y, 3, 0, Math.PI * 2);
        ctx.fill();
        ctx.font = "11px monospace";
        ctx.fillText(label, x + 8, y - 7);
      }
    if (dimensions) {
      const p = M.point(scene.main, scene.main.offset, scene.main.radius);
      const [x, y] = project(p);
      ctx.fillStyle = "#b6c6ca";
      ctx.font = "11px monospace";
      ctx.fillText(`DM ${fmt(scene.apertureDiameter)} ${unit}`, x + 8, y - 8);
    }
  }
  root.AntennaView = { section, model };
})(globalThis);

