#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=musl
version=1.2.3

fetchunpack https://musl.libc.org/releases/musl-$version.tar.gz

cd $WORKDIR/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST --target=$TARGET"
fi

./configure $flags \
	--prefix=/usr
make
make DESTDIR=$PKG install

mkdir -p $PKG/usr/bin
ln -sf ../lib/libc.so $PKG/usr/bin/ldd
mkdir -p $PKG/sbin

pkginstall $version
