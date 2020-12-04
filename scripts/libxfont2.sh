#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: freetype2 libfontenc

name=libxfont2
version=2.0.4
url=http://ftp.x.org/pub/individual/lib/libXfont2-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/libXfont2-$version

./configure \
	 --prefix=/usr \
	 --disable-devel-docs
make
make DESTDIR=$PKG install

xinstall

exit 0
