#!/bin/bash

set -e
set -x

BUILD_DIR="build"
CONAN_DIR="conan"

BASEDIR=$(dirname "$0")
pushd "$BASEDIR"

case $1 in
install)
    if [[ $2 == "-r" ]]; then
        echo "Removing Conan Generated Files"
        rm -rf $CONAN_DIR
    fi
    echo "Installing Dependencies with Conan"
    conan install . --output-folder=$CONAN_DIR --build=missing
    ;;
build)
    if ! [ -d $CONAN_DIR ]; then
        echo "Conan not Setup. Install dependencies first."
        return 1
    fi

    if [[ $2 == "-r" ]]; then
        echo "Removing Meson Generated files"
        rm -rf $BUILD_DIR
    fi

    if ! [ -d $BUILD_DIR ]; then
        echo "Setting up build directory"
        meson setup --native-file $CONAN_DIR/conan_meson_native.ini . $BUILD_DIR
    fi

    echo "Building Binaries"
    meson compile -C build
    ;;

*)
    echo "Unknown Command"
    return 1
    ;;
esac
