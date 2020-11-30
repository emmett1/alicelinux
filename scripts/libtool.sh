#!/bin/sh

set -e

. /etc/pkg.conf
. /var/lib/pkg/functions

name=libtool
version=2.4.6
url=https://ftp.gnu.org/gnu/$name/$name-$version.tar.xz

xfetch $url
xunpack $name-$version.tar.xz

cd $SRC/$name-$version

./configure --prefix=/usr
make
make DESTDIR=$PKG install

xinstall

exit 0
