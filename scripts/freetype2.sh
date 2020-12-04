#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: 

name=freetype2
version=2.10.4
url=https://downloads.sourceforge.net/freetype/freetype-$version.tar.xz

xfetch $url
xunpack ${url##*/}

cd $SRC/freetype-$version

./configure \
	 --prefix=/usr \
	 --enable-freetype-config
make
make DESTDIR=$PKG install

xinstall

exit 0
