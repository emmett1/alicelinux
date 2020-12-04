#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

name=libxshmfence
version=1.3
url=http://ftp.x.org/pub/individual/lib/libxshmfence-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/libxshmfence-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
