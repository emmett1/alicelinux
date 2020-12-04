#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: meson

name=xorgproto
version=2020.1
url=https://xorg.freedesktop.org/archive/individual/proto/$name-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

mkdir build
cd build

meson --prefix=/usr
ninja
DESTDIR=$PKG ninja install

xinstall

exit 0
