#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: libx11

name=libxrender
version=0.9.10
url=http://ftp.x.org/pub/individual/lib/libXrender-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/libXrender-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
