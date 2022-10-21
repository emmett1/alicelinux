#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=libressl
version=3.3.0

fetchunpack https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/$name-$version.tar.gz
fetch https://curl.haxx.se/ca/cacert.pem

cd $WORKDIR/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST"
	CFLAGS="-L$ROOTFS/usr/lib $CFLAGS"
fi

./configure $flags \
	--prefix=/usr \
	--sysconfdir=/etc
make
make DESTDIR=$PKG install

install -Dm644 $SRCDIR/cacert.pem $PKG/etc/ssl/cert.pem

pkginstall $version
