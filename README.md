# My Notes Site

This is my personal notes and digital garden, built and published using [Quartz v4](https://quartz.jzhao.xyz/).

Live site: [https://auroey.github.io/web-digital-garden-ts](https://auroey.github.io/web-digital-garden-ts)

Source repository: [https://github.com/auroey/web-digital-garden-ts](https://github.com/auroey/web-digital-garden-ts)

## Obsidian workflow

The recommended local location is:

```text
D:\4_SelfDoc\obs\60_web
```

Create or edit publishable notes in:

```text
D:\4_SelfDoc\obs\60_web\content
```

Then sync them to the website:

```text
Double-click sync.cmd
```

Or run it from PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\sync-content.ps1
```

The script checks `content`, commits the note changes, pushes to GitHub, and GitHub Pages publishes the updated site.

To validate the site locally before pushing, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\sync-content.ps1 -Build
```
