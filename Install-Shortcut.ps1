# Creates Desktop and Start Menu shortcuts that open the calculator in its own
# window (Microsoft Edge "app" mode: no tabs or address bar). Runs from the local
# file, so no internet is needed. Run once per PC:
#   powershell -ExecutionPolicy Bypass -File .\Install-Shortcut.ps1

$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$html = Join-Path $here 'index.html'
$icon = Join-Path $here 'app.ico'
$url  = ([System.Uri]$html).AbsoluteUri

$edge = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe' -ErrorAction SilentlyContinue).'(default)'
if (-not $edge) { $edge = Join-Path ${env:ProgramFiles(x86)} 'Microsoft\Edge\Application\msedge.exe' }
if (-not (Test-Path $edge)) { throw 'Microsoft Edge was not found on this PC.' }

$shell = New-Object -ComObject WScript.Shell
$targets = @(
  (Join-Path ([Environment]::GetFolderPath('Desktop'))  'AltMill Speeds & Feeds.lnk'),
  (Join-Path ([Environment]::GetFolderPath('Programs')) 'AltMill Speeds & Feeds.lnk')
)
foreach ($path in $targets) {
  $lnk = $shell.CreateShortcut($path)
  $lnk.TargetPath = $edge
  $lnk.Arguments = "--app=`"$url`" --window-size=1500,960"
  $lnk.WorkingDirectory = $here
  $lnk.Description = 'CNC speeds and feeds calculator'
  if (Test-Path $icon) { $lnk.IconLocation = $icon }
  $lnk.Save()
  Write-Host "Created $path"
}
