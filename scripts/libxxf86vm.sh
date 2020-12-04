#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: libx11 libxext

name=libxxf86vm
version=1.1.4
url=http://ftp.x.org/pub/individual/lib/libXxf86vm-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/libXxf86vm-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
