#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

name=libpciaccess
version=0.16
url=http://ftp.x.org/pub/individual/lib/libpciaccess-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

./configure \
	--prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--disable-static
make
make DESTDIR=$PKG install

xinstall

exit 0
