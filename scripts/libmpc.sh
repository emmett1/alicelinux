#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=mpc
version=1.2.1

fetchunpack https://ftp.gnu.org/gnu/mpc/mpc-$version.tar.gz

cd $WORKDIR/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST --target=$TARGET"
fi

./configure $flags \
	--prefix=/usr    \
	--disable-static
make
make DESTDIR=$PKG install

pkginstall $version
