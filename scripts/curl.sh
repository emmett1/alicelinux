#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=curl
version=7.85.0

fetchunpack https://curl.haxx.se/download/$name-$version.tar.xz

cd $WORKDIR/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST"
fi

./configure $flags \
	--prefix=/usr \
	--disable-static \
	--enable-threaded-resolver \
	--with-ca-bundle=/etc/ssl/cert.pem \
	--with-openssl \
	ac_cv_sizeof_off_t=8
make
make DESTDIR=$PKG install

pkginstall $version
