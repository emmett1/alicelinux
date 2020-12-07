#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

name=dhcpcd
version=9.3.4
url=http://roy.marples.name/downloads/$name/$name-$version.tar.xz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

./configure \
	--libexecdir=/lib/dhcpcd \
	--dbdir=/var/lib/dhcpcd
make
make DESTDIR=$PKG install

xinstall

exit 0
