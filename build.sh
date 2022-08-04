#!/usr/bin/env bash

set -eu

info() {
	echo -e "\033[33m$1\033[m"
}

die() {
	echo -e "\033[31m$1\033[m"
	exit 1
}

build_type="Release"
cmake_only="NO"
export CC=clang #"/usr/local/llvm-15-clang/bin/clang"
export CXX=clang++ #"/usr/local/llvm-15-clang/bin/clang++"

if test $# -ge 1; then
    case "$1" in
        "debug")
            build_type="Debug"
            ;;
        "clean")
            mkdir -p ./out
            rm -rf ./out cxx-modules-test
            exit 0
            ;;
        "cmake") cmake_only="YES" ;;
        *)
            die "Unrecognised option '$1'"
            ;;
    esac
fi

mkdir -p ./out
cd out || die "cd error"

## Build the modules.
$CXX -std=gnu++2b -c ../src/std.cc -Xclang -emit-module-interface -o std.pcm

## Build the program.
cmake -DCMAKE_BUILD_TYPE="$build_type" .. -GNinja
if test "$cmake_only" = "YES"; then exit 0; fi

ninja
