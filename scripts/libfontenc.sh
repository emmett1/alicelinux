#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: 

name=libfontenc
version=1.1.4
url=http://ftp.x.org/pub/individual/lib/libfontenc-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
