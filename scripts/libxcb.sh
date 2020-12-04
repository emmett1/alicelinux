#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: xcb-proto libxau

name=libxcb
version=1.14
url=http://xcb.freedesktop.org/dist/libxcb-$version.tar.xz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
