#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: 

name=xinit
version=1.4.1
url=http://ftp.x.org/pub/individual/app/xinit-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

./configure \
	--prefix=/usr \
	--with-xinitdir=/etc/X11/app-defaults
make
make DESTDIR=$PKG install

xinstall

exit 0
