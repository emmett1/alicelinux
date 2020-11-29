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

name=mpfr
version=4.1.0
url=https://www.mpfr.org/$name-$version/$name-$version.tar.xz

xfetch $url
xunpack $name-$version.tar.xz

cd $SRC/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST"
fi

./configure $flags \
	--prefix=/usr \
	--disable-static \
	--enable-thread-safe
make
make DESTDIR=$PKG install

xinstall $version

exit 0
