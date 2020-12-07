#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: cmake zstd

name=ccache
version=4.1
url=https://github.com/ccache/ccache/releases/download/v$version/$name-$version.tar.xz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

mkdir build
cd build

cmake \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/usr \
	..
make
make DESTDIR=$PKG install

install -d $PKG/usr/lib/ccache
for c in gcc g++ cc c++; do
	ln -s /usr/bin/ccache $PKG/usr/lib/ccache/$c
done

xinstall

exit 0
