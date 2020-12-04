#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: mesa meson

name=libepoxy
version=1.5.4
url=https://github.com/anholt/$name/releases/download/$version/$name-$version.tar.xz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

mkdir build
cd build

meson --prefix=/usr ..
ninja
DESTDIR=$PKG ninja install

xinstall

exit 0
