# AltMill Speeds & Feeds Calculator

An offline desktop speeds & feeds program for CNC milling. The owner uses it on two Windows PCs (shop and home). It opens through a Desktop/Start Menu shortcut that runs `index.html` in an Edge app window (see `Install-Shortcut.ps1`). The owner does not use it on the phone, so design for desktop widths (~1400px) first.

- `index.html` is the whole app: HTML, CSS and one JS IIFE at the bottom. No build step and **no network dependencies**: system fonts only (Bahnschrift / Consolas / Segoe UI), with no CDNs or web fonts. Keep it that way.
- `HANDOFF.md` has the background from the original Claude chat: machine specs, past decisions, caveats.
- `Install-Shortcut.ps1` creates the shortcuts (run once per PC). `app.ico` is the shortcut icon.
- The repo is public on GitHub (briannapierstudio/altmill-sf-calc), and GitHub Pages also serves it. Commits use the GitHub no-reply email set in the repo's git config.

## Machine (defaults come from here)
Sienci AltMill Mk2 4x4, Sienci ATC 2.2 kW spindle, 7,500–24,000 RPM, full power from 18,000 RPM. X/Y max 590 IPM (15,000 mm/min), Z max 236 IPM (6,000 mm/min). Rigidity factor 0.7.

## How the code is organized
- **Data:** `CLASS` (engagement defaults per material class, as multiples of D), `MATERIALS` (SFM range, chip load at 1/8, 1/4, 3/8 and 1/2", unit power hp/in³/min, notes), `TOOLMAT`, `COATING`, `COOLANT`, `OPS` / `OPS_FOR` (valid operations per tool type), `BUILTIN_TOOLS`, `MACHINE_DEFAULT`.
- **Math:** `compute(state, tool, adj)` is a pure function returning every result plus a `warn` list. `solve()` wraps it to implement "Fit to machine": it shrinks DOC (then WOC) until power ≤ 80%, deflection ≤ its limit, and bending stress ≤ 60% of allowable. The chart tab calls `solve()` once per row.
- **Units:** all state and math are in inches, IPM and SFM. `DIM` converts for display and input only. Inputs bind with `data-k="path.in.state"` and `data-dim="len|small|feed|rpm|int|num|deg"`, and `data-null="1"` lets an empty field mean "use recommended". There is no per-field conversion code to maintain.
- **State:** saved to localStorage under `altmill-sf-v2`. The tool library moves between PCs through Export/Import JSON, because localStorage doesn't sync.

## Working rules
- Keep it a single offline HTML file with vanilla JS/CSS unless the owner asks otherwise.
- Keep the shop-floor look: dark panels, amber accent (`--accent`), green-on-black readout.
- To test: `python -m http.server 8765 --bind 127.0.0.1` in this folder (Python 3.13 is installed, Node is not), then open http://127.0.0.1:8765/index.html in the browser pane. Check the console for errors and exercise every tool type (flat, ball, bull, V-bit, drill) and both units.
- Presets are generic starting points, not manufacturer data. When changing material numbers, say where they came from.
