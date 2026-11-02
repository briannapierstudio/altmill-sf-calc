# CNC Speeds & Feeds Calculator — Handoff

> **Status, 2026-11-02:** The app has been rebuilt as an offline desktop program for the PC; the iPhone is no longer the target. Everything below describes the original phone version and is kept as background. From the "Next up" list, these are now built: ball-nose effective diameter, scallop and chip thinning (#1); the tool library (#3); saved settings (#4); offline use (#5: system fonts plus a desktop shortcut instead of a PWA); and DOC/WOC recommendations and plunge feed (#6). Still open: a Z-axis vector-feed check for steep 3D walls (#2). See `CLAUDE.md` for how the code is organized now.

## What this is
A single-file, mobile-first web app (`cnc-speeds-feeds.html`, no build step, vanilla JS/CSS) that the owner installs on their iPhone via Safari > Share > Add to Home Screen. It calculates spindle RPM and feed rate for CNC milling and clamps results to the owner's actual machine limits. Design language: shop-floor control panel (dark panels, amber accent, green-on-black "readout" screen; Oswald / Roboto Mono / Inter).

## Owner's machine (source of truth for defaults)
- Machine: Sienci Labs AltMill Mk2 4x4
- Spindle: Sienci automatic tool changer (ATC), 2.2 kW, 220 V single phase, ISO20 holder, air cooled, ceramic bearings
- Spindle RPM: 7,500 to 24,000; constant torque begins at 18,000 RPM
- Axis max speeds (per Sienci resources): X/Y 15,000 mm/min (590 IPM); Z 6,000 mm/min (236 IPM)
- Work: wood, plywood, plastics, aluminum; also does true 3D sculpted surfacing (not just outlines/pockets)

## Current features (all implemented, JS syntax-checked)
- Inch / metric toggle that converts all fields live
- Material chips with starting SFM + chip load: Aluminum, Brass, Mild steel, Stainless, Cast iron, Titanium, Wood/MDF, Plywood, Plastic
- Bit style toggle: Square end mill vs Round-over bit (round-over multiplies SFM and chip load by 0.6)
- Inputs: cutter diameter, flutes (stepper), SFM, chip load, optional MRR (depth/width of cut)
- Spindle section: min RPM, max RPM, full-torque RPM (prefilled above)
- Travel limits section: max X/Y feed (prefilled 590 IPM)
- Readout: RPM = SFM*12/(pi*D), feed = RPM*flutes*chipload; RPM clamped to spindle range; feed clamped to travel max; torque badge (Full / Reduced); amber warnings that report the actual achieved SFM or capped feed when clamping happens
- "Add to home" button toggles inline Safari instructions (alert() was removed; it was blocked in preview contexts)

## Known caveats / decisions
- Presets are generic carbide end-mill starting points for ~1/4"-3/8" tools, not manufacturer data. Footnote says to verify against tool maker data.
- Ferrous metals and titanium at small diameters want RPM below the 7,500 floor, so the app clamps up and warns that real SFM is higher than set. This is a machine limitation, intentionally surfaced rather than hidden.
- Z-axis limit (236 IPM) is NOT in the live clamp, because the app computes lateral cutting feed. Plunge feed is separate.
- Chrome on iOS can't make a standalone home-screen app; Safari is required for the full-screen icon.

## Next up (discussed, not yet built)
1. **Ball-nose / effective-diameter mode** for 3D sculpted surfacing. Effective cutting diameter at depth of engagement ap on a ball of diameter D: `De = 2*sqrt(ap*(D - ap))` (for ap < D/2). RPM should be computed from De, not nominal D. Near the tip De approaches 0, so surface speed collapses; finishing is usually run at a fixed high RPM near spindle max. Add inputs for stepover and engagement, show effective diameter, corrected RPM, and a scallop-height estimate (`h = R - sqrt(R^2 - (stepover/2)^2)`). Also apply radial chip thinning feed compensation when stepover is less than ~half the diameter.
2. **Z-axis note/clamp for steep 3D passes**: combined XYZ vector feed can exceed the Z ceiling (236 IPM) on steep walls. At minimum add a warning; ideally a "steepest wall angle" input that computes max allowed vector feed = 236 / sin(angle).
3. Tool library (save named tools: diameter, flutes, type) via localStorage.
4. Persist settings across launches via localStorage (spindle limits, units, last material).
5. Make it a proper PWA: manifest.json, apple-touch-icon, service worker for offline use, and a self-hosted font fallback (currently loads Google Fonts, which fails offline).
6. Optional: rigidity/DOC/WOC recommendations per material, plunge feed suggestion (often 30-50% of cutting feed).

## Working notes for the next agent
- Everything lives in one HTML file; JS is in a single IIFE at the bottom. Key functions: `selectMaterial`, `setUnit`, `setBitStyle`, `calc`.
- `setUnit` converts values by reading current fields, so any new numeric field with units must be added there and to the input-listener array.
- Validate JS after edits: extract the `<script>` block and run `node --check`.
- Test on a ~390px-wide viewport; the owner uses the app on an iPhone at the machine.
