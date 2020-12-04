#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: meson libpciaccess

name=libdrm
version=2.4.103
url=https://dri.freedesktop.org/$name/$name-$version.tar.xz

xfetch $url
xunpack $name-$version.tar.xz

cd $SRC/$name-$version

mkdir build
cd build
meson --prefix=/usr
ninja
DESTDIR=$PKG ninja install

xinstall

exit 0
