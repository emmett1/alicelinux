#!/bin/sh

set -e

if [ -f $(dirname $(dirname $(realpath $0)))/pkg.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/pkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/pkg.conf
	. /var/lib/pkg/functions
fi

name=curl
version=7.73.0
url=https://curl.haxx.se/download/$name-$version.tar.xz

xfetch $url
xunpack $name-$version.tar.xz

cd $SRC/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST"
fi

./configure $flags \
	--prefix=/usr \
	--disable-static \
	--enable-threaded-resolver \
	--with-ca-bundle=/etc/ssl/cert.pem \
	ac_cv_sizeof_off_t=8
make
make DESTDIR=$PKG install

xinstall $version

exit 0
