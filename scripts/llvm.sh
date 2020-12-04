#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: cmake

name=llvm
version=11.0.0
url=https://github.com/llvm/llvm-project/releases/download/llvmorg-$version/llvm-$version.src.tar.xz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version.src

export CC=${CC:-gcc}
export CXX=${CXX:-g++}

mkdir -v build
cd       build

cmake .. -G Ninja \
	  -DCMAKE_INSTALL_PREFIX=/usr           \
	  -DLLVM_ENABLE_FFI=ON                  \
	  -DCMAKE_BUILD_TYPE=Release            \
	  -DLLVM_BUILD_LLVM_DYLIB=ON            \
	  -DLLVM_LINK_LLVM_DYLIB=ON             \
	  -DLLVM_ENABLE_RTTI=ON                 \
	  -DLLVM_TARGETS_TO_BUILD="X86;AMDGPU;BPF" \
	  -Wno-dev
ninja
DESTDIR=$PKG ninja install

xinstall

exit 0
