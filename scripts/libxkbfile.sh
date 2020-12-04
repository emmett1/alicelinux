#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: libx11

name=libxkbfile
version=1.1.0
url=http://ftp.x.org/pub/individual/lib/libxkbfile-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
