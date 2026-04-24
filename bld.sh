#!/bin/bash

set -e

if [ $# -ne 1 ]; then
    echo "Usage:"
    echo "  ./build -d       build debug"
    echo "  ./build -r       build release"
    echo "  ./build -cd      clean debug"
    echo "  ./build -cr      clean release"
    echo "  ./build -rd      rebuild debug"
    echo "  ./build -rr      rebuild release"
    echo "  ./build -run-d   build and run debug"
    echo "  ./build -run-r   build and run release"
    exit 1
fi

PROJECT_NAME="MyQtProject"
ARG=$1

case $ARG in
    -d)
        ACTION="build"
        CONFIG="Debug"
        ;;
    -r)
        ACTION="build"
        CONFIG="Release"
        ;;
    -cd)
        ACTION="clean"
        CONFIG="Debug"
        ;;
    -cr)
        ACTION="clean"
        CONFIG="Release"
        ;;
    -rd)
        ACTION="rebuild"
        CONFIG="Debug"
        ;;
    -rr)
        ACTION="rebuild"
        CONFIG="Release"
        ;;
    -run-d)
        ACTION="run"
        CONFIG="Debug"
        ;;
    -run-r)
        ACTION="run"
        CONFIG="Release"
        ;;
    *)
        echo "Invalid option: $ARG"
        exit 1
        ;;
esac

BUILD_DIR=".build/${CONFIG,,}"
EXECUTABLE="$BUILD_DIR/bin/$CONFIG/$PROJECT_NAME"

echo "Action: $ACTION"
echo "Config: $CONFIG"
echo "Build dir: $BUILD_DIR"

clean_build_dir() {
    echo "Cleaning $BUILD_DIR..."
    rm -rf "$BUILD_DIR"
}

build_project() {
    echo "Configuring..."
    cmake -S . -B "$BUILD_DIR" -DCMAKE_BUILD_TYPE=$CONFIG

    echo "Building with parallel jobs..."
    cmake --build "$BUILD_DIR" --parallel "$(nproc)"
}

run_project() {
    if [ ! -f "$EXECUTABLE" ]; then
        echo "Executable not found: $EXECUTABLE"
        exit 1
    fi

    echo "Running $EXECUTABLE..."
    "$EXECUTABLE"
}

case $ACTION in
    clean)
        clean_build_dir
        ;;
    build)
        build_project
        ;;
    rebuild)
        clean_build_dir
        build_project
        ;;
    run)
        build_project
        run_project
        ;;
esac

echo "Done."