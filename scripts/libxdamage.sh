#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: libxfixes

name=libxdamage
version=1.1.5
url=http://ftp.x.org/pub/individual/lib/libXdamage-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/libXdamage-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
