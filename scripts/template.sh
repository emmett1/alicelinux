#!/bin/sh

set -e

. /etc/pkg.conf
. /var/lib/pkg/functions

name=
version=
url=

xfetch $url
xunpack $name-$version.tar.xz

cd $SRC/$name-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall $version

exit 0
