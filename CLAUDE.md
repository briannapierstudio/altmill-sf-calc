# AltMill Speeds & Feeds Calculator

Single-file, mobile-first web app for CNC milling speeds & feeds. The owner uses it on an iPhone at the machine (Safari > Share > Add to Home Screen) and edits it on two Windows PCs (shop and home).

- `index.html` is the whole app: HTML, CSS and one JS IIFE at the bottom. No build step, no dependencies besides Google Fonts.
- `HANDOFF.md` has the full background: machine specs, design decisions, caveats, and the **Next up** feature list. Read it before making feature changes.

## Machine (defaults come from here)
Sienci AltMill Mk2 4x4, Sienci ATC 2.2 kW spindle, 7,500–24,000 RPM, full torque from 18,000 RPM. X/Y max 590 IPM (15,000 mm/min), Z max 236 IPM (6,000 mm/min).

## Working rules
- Keep it a single HTML file with vanilla JS/CSS unless the owner asks otherwise.
- Key functions: `selectMaterial`, `setUnit`, `setBitStyle`, `calc`. Any new numeric field with units must be converted in `setUnit` and added to the input-listener array.
- Keep the shop-floor look: dark panels, amber accent (`--accent`), green-on-black readout, Oswald / Roboto Mono / Inter.
- Test at ~390px width (iPhone). Node is not installed on the shop PC, so check for JS errors by loading the page in the browser pane and reading the console.
- When a "Next up" item from HANDOFF.md is built, move it into "Current features" there.
