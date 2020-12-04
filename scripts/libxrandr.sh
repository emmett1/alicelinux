#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: libxrender

name=libxrandr
version=1.5.2
url=http://ftp.x.org/pub/individual/lib/libXrandr-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/libXrandr-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
