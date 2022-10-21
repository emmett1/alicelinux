#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=zlib
version=1.2.13

fetchunpack https://zlib.net/$name-$version.tar.xz

cd $WORKDIR/$name-$version

if [ "$BOOTSTRAP" ]; then
	export CHOST=$TARGET
	export CC=$CC
fi

./configure --prefix=/usr
make
make DESTDIR=$PKG install

mkdir -p $PKG/lib
mv -v $PKG/usr/lib/libz.so.* $PKG/lib
ln -sfv ../../lib/$(readlink $PKG/usr/lib/libz.so) $PKG/usr/lib/libz.so

pkginstall $version
