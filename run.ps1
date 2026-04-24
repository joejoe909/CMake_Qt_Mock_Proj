param(
    [Parameter(Mandatory=$true)]
    [string]$Arg
)

$ProjectName = "MyQtProject"

switch ($Arg) {
    "-d" { $Config = "Debug" }
    "-r" { $Config = "Release" }
    default {
        Write-Host "Usage:"
        Write-Host "  .\run.ps1 -d   run debug"
        Write-Host "  .\run.ps1 -r   run release"
        exit
    }
}

$BuildDir = ".build/" + $Config.ToLower()
$Executable = "$BuildDir/bin/$Config/$ProjectName.exe"

Write-Host "Running config: $Config"
Write-Host "Executable: $Executable"

if (!(Test-Path $Executable)) {
    Write-Host "Executable not found."
    Write-Host "Did you forget to build?"
    exit
}

& $Executable