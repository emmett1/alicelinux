#!/bin/sh -e

CARCH="x86_64"
HOST=$(gcc -dumpmachine | sed "s/-[^-]*/-cross/")
TARGET="$CARCH-linux-musl"

ROOTFS="$PWD/$TARGET-rootfs"
CROSSTOOL="$PWD/$TARGET-crosstool"
THREADS="$(nproc)"
MAKEFLAGS="-j$THREADS"
CFLAGS="${CFLAGS:--O2 -march=x86-64 -pipe}"
CXXFLAGS="${CXXFLAGS:-${CFLAGS}}"

cat << EOF > conf
export HOST="$HOST"
export TARGET="$TARGET"
export CARCH="$CARCH"
export MAKEFLAGS="$MAKEFLAGS"
export ROOTFS="$ROOTFS"
export CROSSTOOL="$CROSSTOOL"
export PATH=$CROSSTOOL/bin:$PATH
export BOOTSTRAP=1
export CROSS_COMPILE="$TARGET-"
export CFLAGS="$CFLAGS"
export CXXFLAGS="$CXXFLAGS"
export CC="$TARGET-gcc"
export CXX="$TARGET-g++"
export AR="$TARGET-ar"
export AS="$TARGET-as"
export RANLIB="$TARGET-ranlib"
export LD="$TARGET-ld"
export STRIP="$TARGET-strip"
export PKG_CONFIG_PATH="$ROOTFS/usr/lib/pkgconfig:$ROOTFS/usr/share/pkgconfig"
#export PKG_CONFIG_SYSROOT_DIR="$ROOTFS"
EOF

cat << EOF > crosstool-conf
export HOST="$HOST"
export TARGET="$TARGET"
export CARCH="$CARCH"
export MAKEFLAGS="$MAKEFLAGS"
export ROOTFS="$ROOTFS"
export CROSSTOOL="$CROSSTOOL"
export PATH=$CROSSTOOL/bin:$PATH
export BOOTSTRAP=1
EOF

touch .done
for i in linux-headers cross-binutils cross-gcc-static musl \
	cross-gcc filesystem zlib binutils m4 libgmp libmpfr \
	libmpc gcc make file busybox libressl curl; do
	grep -qx $i .done && continue
	case $i in
		cross-*) ROOT=$ROOTFS CONF=$(realpath ./crosstool-conf) ./scripts/$i.sh;;
		*)       ROOT=$ROOTFS CONF=$(realpath ./conf) ./scripts/$i.sh;;
	esac
	[ $? = 0 ] && echo $i >> .done || exit 1
done
