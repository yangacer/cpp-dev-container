# Overview

A Docker container ready for developing/building C++ projects with LLVM toolchain.

# Files

* Dockerfile
  Invoking other scripts and install required packages.
* llvm.sh [official version](https://apt.llvm.org/llvm.sh)
  Installing LLVM toolchain including clang. The file hardcodes LLVM version number.
  I've patched it to invoke `update-alternatives-clang.sh` with the version number accordingly.
* update-alternatives-clang.sh
  Create non-versional alias of various LLVM CLI tools.
* inputrc
  A bonus bash inputrc configuration enabled by default.
