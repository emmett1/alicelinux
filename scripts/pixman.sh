#!/bin/sh

set -e

. /etc/pkg.conf
. /var/lib/pkg/functions

name=pixman
version=0.40.0
url=https://cairographics.org/releases/$name-$version.tar.gz

xfetch $url
xunpack $name-$version.tar.gz

cd $SRC/$name-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
