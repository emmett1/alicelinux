#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: meson

name=libglvnd
version=1.3.2
url=https://github.com/NVIDIA/libglvnd/archive/v$version/$name-v$version.tar.gz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

mkdir build
cd build

meson --prefix=/usr -Dtls=disabled
ninja
DESTDIR=$PKG ninja install

xinstall

exit 0
