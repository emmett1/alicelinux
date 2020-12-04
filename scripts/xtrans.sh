#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends:

name=xtrans
version=1.4.0
url=http://ftp.x.org/pub/individual/lib/xtrans-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
