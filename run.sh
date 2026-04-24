#!/bin/bash

set -e

if [ $# -ne 1 ]; then
    echo "Usage:"
    echo "  ./run -d   run debug"
    echo "  ./run -r   run release"
    exit 1
fi

PROJECT_NAME="MyQtProject"
ARG=$1

case $ARG in
    -d)
        CONFIG="Debug"
        ;;
    -r)
        CONFIG="Release"
        ;;
    *)
        echo "Invalid option: $ARG"
        exit 1
        ;;
esac

BUILD_DIR=".build/${CONFIG,,}"
EXECUTABLE="$BUILD_DIR/bin/$CONFIG/$PROJECT_NAME"

echo "Running config: $CONFIG"
echo "Executable: $EXECUTABLE"

if [ ! -f "$EXECUTABLE" ]; then
    echo "Executable not found."
    echo "Did you forget to build? Try:"
    echo "  ./build -${CONFIG,,}"
    exit 1
fi

"$EXECUTABLE"