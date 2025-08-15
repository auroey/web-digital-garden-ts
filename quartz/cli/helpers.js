import { isCancel, outro } from "@clack/prompts"
import { inspect } from "util"

// Polyfill for styleText in older Node.js versions
const styleText = (color, text) => {
  const colors = {
    red: '\x1b[31m',
    green: '\x1b[32m',
    yellow: '\x1b[33m',
    blue: '\x1b[34m',
    magenta: '\x1b[35m',
    cyan: '\x1b[36m',
    reset: '\x1b[0m'
  }
  return `${colors[color] || ''}${text}${colors.reset}`
}
import { contentCacheFolder } from "./constants.js"
import { spawnSync } from "child_process"
import fs from "fs"

export function escapePath(fp) {
  return fp
    .replace(/\\ /g, " ") // unescape spaces
    .replace(/^".*"$/, "$1")
    .replace(/^'.*"$/, "$1")
    .trim()
}

export function exitIfCancel(val) {
  if (isCancel(val)) {
    outro(styleText("red", "Exiting"))
    process.exit(0)
  } else {
    return val
  }
}

export async function stashContentFolder(contentFolder) {
  await fs.promises.rm(contentCacheFolder, { force: true, recursive: true })
  await fs.promises.cp(contentFolder, contentCacheFolder, {
    force: true,
    recursive: true,
    verbatimSymlinks: true,
    preserveTimestamps: true,
  })
  await fs.promises.rm(contentFolder, { force: true, recursive: true })
}

export function gitPull(origin, branch) {
  const flags = ["--no-rebase", "--autostash", "-s", "recursive", "-X", "ours", "--no-edit"]
  const out = spawnSync("git", ["pull", ...flags, origin, branch], { stdio: "inherit" })
  if (out.stderr) {
    throw new Error(styleText("red", `Error while pulling updates: ${out.stderr}`))
  } else if (out.status !== 0) {
    throw new Error(styleText("red", "Error while pulling updates"))
  }
}

export async function popContentFolder(contentFolder) {
  await fs.promises.rm(contentFolder, { force: true, recursive: true })
  await fs.promises.cp(contentCacheFolder, contentFolder, {
    force: true,
    recursive: true,
    verbatimSymlinks: true,
    preserveTimestamps: true,
  })
  await fs.promises.rm(contentCacheFolder, { force: true, recursive: true })
}
