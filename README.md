# AltMill Speeds & Feeds

RPM and feed-rate calculator for the Sienci AltMill Mk2 + 2.2 kW ATC spindle.

## Use it
- **On this PC:** double-click `index.html` to open it in your browser.
- **On the iPhone:** the page has to be served from a web address. Safari can't add a local file to the home screen. The easiest option is free GitHub Pages hosting (see below). Then open the link in Safari, tap Share, then Add to Home Screen.

## Change it
Open a Claude Code session in this folder and describe the change. `CLAUDE.md` and `HANDOFF.md` give Claude the background, and the planned features are listed under "Next up" in `HANDOFF.md`.

## Keep the shop and home PCs in sync
The project lives on GitHub at https://github.com/briannapierstudio/altmill-sf-calc (private).

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
Then open a Claude Code session in that folder.

**Day to day:** before you start work on a PC, ask Claude to "pull the latest". When you're done, ask it to "commit and push". That keeps the two PCs from drifting apart.
