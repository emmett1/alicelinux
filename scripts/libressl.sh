#!/bin/sh

set -e

if [ -f $(dirname $(dirname $(realpath $0)))/main.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/main.conf
	. $(dirname $(dirname $(realpath $0)))/pkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/pkg.conf
	. /var/lib/pkg/functions
fi

name=libressl
version=3.3.0
url=https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/$name-$version.tar.gz
certurl=https://curl.haxx.se/ca/cacert.pem

xfetch $url
xfetch $certurl
xunpack $name-$version.tar.gz

cd $SRC/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST"
	CFLAGS="-L$ROOT_DIR/usr/lib $CFLAGS"
fi

./configure $flags \
	--prefix=/usr \
	--sysconfdir=/etc
make
make DESTDIR=$PKG install

install -Dm644 $SOURCE_DIR/cacert.pem $PKG/etc/ssl/cert.pem
#install -m755 $SRC/cert-update $PKG/usr/bin/cert-update

xinstall $version

exit 0
