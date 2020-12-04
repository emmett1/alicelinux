#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

name=libxext
version=1.3.4
url=http://ftp.x.org/pub/individual/lib/libXext-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/libXext-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
