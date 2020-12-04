#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: xorgproto

name=libxau
version=1.0.9
url=http://ftp.x.org/pub/individual/lib/libXau-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/libXau-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
