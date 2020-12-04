#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: 

name=libxml2
version=2.9.10
url=http://xmlsoft.org/sources/$name-$version.tar.gz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

./configure \
	--prefix=/usr \
	--disable-static \
	--with-history \
	--with-icu \
	--with-python=/usr/bin/python3
make
make DESTDIR=$PKG install

xinstall

exit 0
