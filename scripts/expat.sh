#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

name=expat
version=2.2.10
url=https://sourceforge.net/projects/expat/files/expat/$version/expat-$version.tar.bz2

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
