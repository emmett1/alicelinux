#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

name=libxfixes
version=5.0.3
url=http://ftp.x.org/pub/individual/lib/libXfixes-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/libXfixes-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
