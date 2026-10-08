// Small local-only static server. No runtime packages required.
const http = require("node:http");
const fs = require("node:fs");
const path = require("node:path");
const root = path.resolve(__dirname, "..");
const port = Number(process.env.PORT || 8000);
const publicFiles = new Set([
  "index.html",
  "app.js",
  "geometry.js",
  "styles.css",
  "GRANET.FOR",
  "GRANEOC.FOR",
  "open-cassegrain.js",
  "antenna-model.js",
  "polynomials.js",
  "pattern.js",
  "visualization.js",
  "analysis-ui.js",
]);
const types = {
  ".html": "text/html; charset=utf-8",
  ".js": "text/javascript; charset=utf-8",
  ".css": "text/css; charset=utf-8",
  ".FOR": "text/plain; charset=utf-8",
};
const server = http.createServer((req, res) => {
  let name;
  try {
    name =
      decodeURIComponent(new URL(req.url, "http://localhost").pathname).replace(
        /^\//,
        "",
      ) || "index.html";
  } catch {
    res.writeHead(400);
    res.end("Bad request");
    return;
  }
  if (!["GET", "HEAD"].includes(req.method)) {
    res.writeHead(405);
    res.end();
    return;
  }
  if (!publicFiles.has(name)) {
    res.writeHead(404);
    res.end("Not found");
    return;
  }
  res.writeHead(200, {
    "Content-Type": types[path.extname(name)] || "application/octet-stream",
    "Cache-Control": "no-store",
    "X-Content-Type-Options": "nosniff",
  });
  if (req.method === "HEAD") res.end();
  else fs.createReadStream(path.join(root, name)).pipe(res);
});
server.on("error", (error) => {
  console.error(`Cannot start local preview: ${error.message}`);
  process.exitCode = 1;
});
server.listen(port, "127.0.0.1", () =>
  console.log(`Cassegrain Lab: http://127.0.0.1:${server.address().port}`),
);

