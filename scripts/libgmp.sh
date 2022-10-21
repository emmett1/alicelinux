#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=gmp
version=6.2.1

fetchunpack https://ftp.gnu.org/gnu/gmp/$name-$version.tar.xz

cd $WORKDIR/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET"
fi

./configure $flags \
	--prefix=/usr \
	--enable-cxx \
	--build=${HOST:-x86_64-pc-linux-musl} \
	--disable-static
make
make DESTDIR=$PKG install

pkginstall $version
