#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=binutils
version=2.39

fetchunpack https://ftp.gnu.org/gnu/binutils/$name-$version.tar.xz

cd $WORKDIR/$name-$version

mkdir build
cd build

../configure \
	--prefix="$CROSSTOOL" \
	--target="$TARGET" \
	--with-sysroot="$ROOTFS" \
	--disable-nls \
	--disable-multilib
make configure-host
make
make install

rm -fr $WORKDIR $PKG
