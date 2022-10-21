#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=make
version=4.3

fetchunpack https://ftp.gnu.org/gnu/$name/$name-$version.tar.gz

cd $WORKDIR/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST"
fi

./configure $flags \
	--prefix=/usr \
	--disable-nls \
	--without-guile
make
make DESTDIR=$PKG install

pkginstall $version
