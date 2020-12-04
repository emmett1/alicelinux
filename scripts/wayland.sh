#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: libxml2

name=wayland
version=1.18.0
url=http://wayland.freedesktop.org/releases/$name-$version.tar.xz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

./configure \
	--prefix=/usr \
	--disable-static \
	--disable-documentation
make
make DESTDIR=$PKG install

xinstall

exit 0
