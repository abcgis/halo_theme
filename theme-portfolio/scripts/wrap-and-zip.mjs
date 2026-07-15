#!/usr/bin/env node
// Wrap theme contents inside <metadata.name>/ and produce
// <dist>/<metadata.name>-<spec.version>.zip using only Node builtins.
// No `npm install` required.
//
// Usage:  node scripts/wrap-and-zip.mjs [SRC_DIR] [OUT_DIR]
//   SRC defaults to the theme root (parent of this scripts/ folder)
//   OUT defaults to <SRC>/dist
//
// ZIP layout produced (POSIX paths, stored uncompressed):
//   theme-name/<all source files>
//   central directory + EOCD record
//
// Why this script exists: Halo expects the uploaded theme zip
// to have <metadata.name>/ as its top-level entry. Some packagers
// (including @halo-dev/theme-package-cli) glob from process.cwd(),
// which produces a zip missing that wrapper. This script always
// prefixes entries with `${themeName}/` and ignores dev-only paths.

import path from "node:path";
import fs from "node:fs";
import { Buffer } from "node:buffer";
import { fileURLToPath } from "node:url";

const SCRIPTS_DIR = path.dirname(fileURLToPath(import.meta.url));
const SRC = process.argv[2]
  ? path.resolve(process.argv[2])
  : path.resolve(SCRIPTS_DIR, "..");
const OUT = process.argv[3]
  ? path.resolve(process.argv[3])
  : path.join(SRC, "dist");

// --- Read theme.yaml for metadata.name and spec.version ----------
// We only need these two scalars, so a targeted regex beats a full
// YAML parser. If theme.yaml ever grows beyond this subset, swap in
// `yaml` from a local dependency.
const yamlText = fs.readFileSync(path.join(SRC, "theme.yaml"), "utf8");

const metadataBlock = yamlText.match(
  /^metadata:\s*\n([\s\S]*?)(?=^[a-zA-Z]|\Z)/m,
);
const themeName = metadataBlock
  ? metadataBlock[1].match(/^\s*name:\s*(\S+)\s*$/m)?.[1]
  : undefined;
const themeVersion = yamlText.match(/^\s*version:\s*(\S+)\s*$/m)?.[1];

if (!themeName || !themeVersion) {
  console.error(
    `theme.yaml missing metadata.name or spec.version (got name=${themeName}, version=${themeVersion})`,
  );
  process.exit(1);
}
// --- File walker --------------------------------------------------
const ignore = [
  /^dist\//,
  /^node_modules\//,
  /^scripts\/__pycache__\//,
  /\.git\//,
  /\.idea\//,
  /\.DS_Store$/,
  /\.gitignore$/,
  /\.gitattributes$/,
  /^package(-lock)?\.json$/,
  /^pnpm-lock\.yaml$/,
  /^yarn\.lock$/,
  /wrap-and-zip\.mjs$/,
];

function walk(dir, base, out = []) {
  for (const ent of fs.readdirSync(dir, { withFileTypes: true })) {
    const abs = path.join(dir, ent.name);
    const rel = path.relative(base, abs).split(path.sep).join("/");
    if (ignore.some((r) => r.test(rel))) continue;
    if (ent.isDirectory()) walk(abs, base, out);
    else out.push(rel);
  }
  return out;
}

const files = walk(SRC, SRC);

// --- CRC32 table for ZIP ------------------------------------------
const CRC_TABLE = (() => {
  const t = new Uint32Array(256);
  for (let i = 0; i < 256; i++) {
    let c = i;
    for (let k = 0; k < 8; k++) {
      c = (c & 1) ? (0xEDB88320 ^ (c >>> 1)) : (c >>> 1);
    }
    t[i] = c >>> 0;
  }
  return t;
})();

function crc32(buf) {
  let c = 0xFFFFFFFF;
  for (let i = 0; i < buf.length; i++) {
    c = CRC_TABLE[(c ^ buf[i]) & 0xFF] ^ (c >>> 8);
  }
  return (c ^ 0xFFFFFFFF) >>> 0;
}

// --- DOS time/date for ZIP timestamps -----------------------------
const now = new Date();
const dosTime =
  ((now.getHours() & 0x1F) << 11) |
  ((now.getMinutes() & 0x3F) << 5) |
  (Math.floor(now.getSeconds() / 2) & 0x1F);
const dosDate =
  (((now.getFullYear() - 1980) & 0x7F) << 9) |
  (((now.getMonth() + 1) & 0x0F) << 5) |
  (now.getDate() & 0x1F);

// --- Build ZIP byte stream ----------------------------------------
fs.mkdirSync(OUT, { recursive: true });
const zipPath = path.join(OUT, `${themeName}-${themeVersion}.zip`);

const localChunks = [];
const centralChunks = [];
let offset = 0;

for (const rel of files) {
  const data = fs.readFileSync(path.join(SRC, rel));
  const name = `${themeName}/${rel}`;
  const nameBuf = Buffer.from(name, "utf8");
  const crc = crc32(data);

  // Local file header (30 bytes)
  const lfh = Buffer.alloc(30);
  lfh.writeUInt32LE(0x04034b50, 0); // signature
  lfh.writeUInt16LE(20, 4); // version needed
  lfh.writeUInt16LE(0, 6); // flags
  lfh.writeUInt16LE(0, 8); // method (0 = store)
  lfh.writeUInt16LE(dosTime, 10);
  lfh.writeUInt16LE(dosDate, 12);
  lfh.writeUInt32LE(crc, 14);
  lfh.writeUInt32LE(data.length, 18); // compressed size
  lfh.writeUInt32LE(data.length, 22); // uncompressed size
  lfh.writeUInt16LE(nameBuf.length, 26);
  lfh.writeUInt16LE(0, 28); // extra field length

  localChunks.push(lfh, nameBuf, data);

  // Central directory entry (46 bytes)
  const cd = Buffer.alloc(46);
  cd.writeUInt32LE(0x02014b50, 0); // signature
  cd.writeUInt16LE(20, 4); // version made by
  cd.writeUInt16LE(20, 6); // version needed
  cd.writeUInt16LE(0, 8); // flags
  cd.writeUInt16LE(0, 10); // method
  cd.writeUInt16LE(dosTime, 12);
  cd.writeUInt16LE(dosDate, 14);
  cd.writeUInt32LE(crc, 16);
  cd.writeUInt32LE(data.length, 20);
  cd.writeUInt32LE(data.length, 24);
  cd.writeUInt16LE(nameBuf.length, 28);
  cd.writeUInt16LE(0, 30); // extra length
  cd.writeUInt16LE(0, 32); // comment length
  cd.writeUInt16LE(0, 34); // disk number
  cd.writeUInt16LE(0, 36); // internal attrs
  cd.writeUInt32LE(0, 38); // external attrs
  cd.writeUInt32LE(offset, 42); // local header offset

  offset += lfh.length + nameBuf.length + data.length;
  centralChunks.push(cd, nameBuf);
}

const cdSize = centralChunks.reduce((s, b) => s + b.length, 0);
const cdOffset = offset;

// End of central directory record (22 bytes)
const eocd = Buffer.alloc(22);
eocd.writeUInt32LE(0x06054b50, 0);
eocd.writeUInt16LE(0, 4); // disk number
eocd.writeUInt16LE(0, 6); // start disk
eocd.writeUInt16LE(files.length, 8);
eocd.writeUInt16LE(files.length, 10);
eocd.writeUInt32LE(cdSize, 12);
eocd.writeUInt32LE(cdOffset, 16);
eocd.writeUInt16LE(0, 20); // comment length

fs.writeFileSync(
  zipPath,
  Buffer.concat([...localChunks, ...centralChunks, eocd]),
);
const size = fs.statSync(zipPath).size;
console.log(`OK  ${zipPath}`);
console.log(
  `    ${(size / 1024).toFixed(1)} KB, ${files.length} files, top-level=${themeName}/`,
);
