$ErrorActionPreference = "Stop"

function Find-Iscc {
    $fromPath = Get-Command "iscc.exe" -ErrorAction SilentlyContinue
    if ($fromPath) { return $fromPath.Source }

    $candidates = @(
        "C:\Program Files (x86)\Inno Setup 6\ISCC.exe",
        "C:\Program Files\Inno Setup 6\ISCC.exe"
    )

    foreach ($path in $candidates) {
        if (Test-Path $path) { return $path }
    }

    throw "ISCC.exe (Inno Setup) was not found on PATH or in common locations."
}

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$iscc = Find-Iscc
$iss = Join-Path $scriptRoot "RDPManager.iss"

if (-not (Test-Path $iss)) {
    throw "Missing installer definition: $iss"
}

& $iscc $iss
