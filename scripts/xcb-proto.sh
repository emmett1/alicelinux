#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

name=xcb-proto
version=1.14
url=http://xcb.freedesktop.org/dist/xcb-proto-$version.tar.xz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
