#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: libxcb xtrans

name=libx11
version=1.7.0
url=http://ftp.x.org/pub/individual/lib/libX11-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/libX11-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
