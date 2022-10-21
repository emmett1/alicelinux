#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=file
version=5.39

fetchunpack ftp://ftp.astron.com/pub/$name/$name-$version.tar.gz

cd $WORKDIR/$name-$version

mkdir build
cd build
CC=gcc ../configure \
	--disable-bzlib      \
	--disable-libseccomp \
	--disable-xzlib      \
	--disable-zlib
make
cd -

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST"
fi

./configure $flags \
	--prefix=/usr \
	--enable-fsect-man5 \
	--enable-static \
	--disable-libseccomp
make FILE_COMPILE=$PWD/build/src/file
make DESTDIR=$PKG install

pkginstall $version
