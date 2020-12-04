#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

name=musl-fts
version=1.2.7
url=https://github.com/pullmoll/musl-fts/archive/v$version/$name-$version.tar.gz

xfetch $url
xunpack $name-$version.tar.gz

cd $SRC/$name-$version

./bootstrap.sh
./configure --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
