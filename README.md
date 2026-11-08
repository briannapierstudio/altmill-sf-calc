# AltMill Speeds & Feeds

An offline speeds & feeds program for the Sienci AltMill Mk2 with the 2.2 kW ATC spindle. No internet is needed.

## Features
- **Calculator:** RPM, feed, plunge, DOC/WOC, chip load, MRR, spindle power and torque against the machine's power curve, cutting force, tool deflection, breakage risk, scallop height, and cut time.
- **36 materials:** woods, plastics, composites, aluminum alloys, brass and copper, steels, stainless, cast iron, and titanium.
- **5 tool types:** flat, ball nose, bull nose, V-bit and drill, with carbide/HSS/cobalt and four coatings.
- **10 operations:** slotting, profiling, adaptive/HSM clearing, pocketing, finish wall pass, surfacing, 3D roughing, 3D finishing, V-carving and drilling.
- **Chip thinning compensation:** radial chip thinning and ball-nose effective diameter.
- **Fit to machine:** automatically reduces depth of cut when spindle power, deflection or breakage limits are exceeded.
- **Chart tab:** a full speeds & feeds chart across 12 tool diameters, or across every material. It's printable.
- **Tool library:** 19 built-in tools, plus your own. Use Export/Import to move them between PCs.
- **Bit codes:** type or scan a code from the packaging (Amazon `X00…` label or maker part number) to load the bit. The first time, paste the label or product title and the app reads the dimensions and remembers the code.
- **Manufacturer rates:** Amana's published rates for its Spektra spiral plunge bits, with a switch to go back to the calculator's numbers.
- **Machine tab:** an editable machine profile with a power-curve graph.
- **Units:** inch and metric.

## Install on a PC (one time)
1. Get the project folder. See *Keep the shop and home PCs in sync* below.
2. In that folder, right-click `Install-Shortcut.ps1` and choose **Run with PowerShell**. Or run:
   ```
   powershell -ExecutionPolicy Bypass -File .\Install-Shortcut.ps1
   ```
3. Open **AltMill Speeds & Feeds** from the Desktop or Start Menu. It opens in its own window, with no browser tabs or address bar.

Your settings and saved tools stay on each PC. To copy your tools to the other PC, use **Tool library → Export**, then **Import** on the other PC.

## Change it
Open a Claude Code session in this folder and describe the change. `CLAUDE.md` explains how the code is organized.

## Keep the shop and home PCs in sync
The project lives on GitHub at https://github.com/briannapierstudio/altmill-sf-calc (public).

**First-time setup on another PC** (run in PowerShell):
```
winget install --id Git.Git -e
winget install --id GitHub.cli -e
```
Close and reopen PowerShell, then:
```
gh auth login --web
cd $HOME
gh repo clone briannapierstudio/altmill-sf-calc "ALTMILL_SF CALC"
```
Then run `Install-Shortcut.ps1` (above) and open a Claude Code session in that folder.

**Day to day:** before you start work on a PC, ask Claude to "pull the latest". When you're done, ask it to "commit and push".

*A web copy is also published at https://briannapierstudio.github.io/altmill-sf-calc/, but the desktop shortcut doesn't need it.*
