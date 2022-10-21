#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=mpfr
version=4.1.0

fetchunpack https://www.mpfr.org/$name-$version/$name-$version.tar.xz

cd $WORKDIR/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST"
fi

./configure $flags \
	--prefix=/usr \
	--disable-static \
	--enable-thread-safe
make
make DESTDIR=$PKG install

pkginstall $version
