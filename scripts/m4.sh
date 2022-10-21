#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=m4
version=1.4.18

fetchunpack https://ftp.gnu.org/gnu/$name/$name-$version.tar.xz

cd $WORKDIR/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST"
fi

./configure $flags --prefix=/usr
make
make DESTDIR=$PKG install

pkginstall $version
