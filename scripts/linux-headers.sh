#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=linux
version=5.15.74

fetchunpack https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$version.tar.xz

cd $WORKDIR/$name-$version

if [ "$BOOTSTRAP" ]; then
	cross="ARCH=$CARCH"
fi
echo $cross mrproper
make $cross mrproper
make $cross headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
mkdir -p $PKG/usr/include
cp -rv usr/include/* $PKG/usr/include

pkginstall $version
