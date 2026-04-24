param(
    [Parameter(Mandatory=$true)]
    [string]$Arg
)

$ProjectName = "MyQtProject"

switch ($Arg) {
    "-d" {
        $Action = "build"
        $Config = "Debug"
    }
    "-r" {
        $Action = "build"
        $Config = "Release"
    }
    "-cd" {
        $Action = "clean"
        $Config = "Debug"
    }
    "-cr" {
        $Action = "clean"
        $Config = "Release"
    }
    "-rd" {
        $Action = "rebuild"
        $Config = "Debug"
    }
    "-rr" {
        $Action = "rebuild"
        $Config = "Release"
    }
    "-run-d" {
        $Action = "run"
        $Config = "Debug"
    }
    "-run-r" {
        $Action = "run"
        $Config = "Release"
    }
    default {
        Write-Host "Usage:"
        Write-Host "  .\build.ps1 -d       build debug"
        Write-Host "  .\build.ps1 -r       build release"
        Write-Host "  .\build.ps1 -cd      clean debug"
        Write-Host "  .\build.ps1 -cr      clean release"
        Write-Host "  .\build.ps1 -rd      rebuild debug"
        Write-Host "  .\build.ps1 -rr      rebuild release"
        Write-Host "  .\build.ps1 -run-d   build and run debug"
        Write-Host "  .\build.ps1 -run-r   build and run release"
        exit
    }
}

$BuildDir = ".build/" + $Config.ToLower()
$Executable = "$BuildDir/bin/$Config/$ProjectName.exe"

Write-Host "Action: $Action"
Write-Host "Config: $Config"
Write-Host "Build dir: $BuildDir"

function Clean-BuildDir {
    Write-Host "Cleaning $BuildDir..."
    Remove-Item -Recurse -Force $BuildDir -ErrorAction SilentlyContinue
}

function Build-Project {
    Write-Host "Configuring..."
    cmake -S . -B $BuildDir -DCMAKE_BUILD_TYPE=$Config

    Write-Host "Building with parallel jobs..."
    cmake --build $BuildDir --parallel
}

function Run-Project {
    if (!(Test-Path $Executable)) {
        Write-Host "Executable not found: $Executable"
        exit
    }

    Write-Host "Running $Executable..."
    & $Executable
}

switch ($Action) {
    "clean" {
        Clean-BuildDir
    }
    "build" {
        Build-Project
    }
    "rebuild" {
        Clean-BuildDir
        Build-Project
    }
    "run" {
        Build-Project
        Run-Project
    }
}

Write-Host "Done."