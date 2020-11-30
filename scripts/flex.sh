#!/bin/sh

set -e

. /etc/pkg.conf
. /var/lib/pkg/functions

name=flex
version=2.6.4
url=https://github.com/westes/flex/releases/download/v$version/$name-$version.tar.gz

xfetch $url
xunpack $name-$version.tar.gz

cd $SRC/$name-$version

./configure $flags \
	--prefix=/usr
make
make DESTDIR=$PKG install
ln -sv flex $PKG/usr/bin/lex

xinstall

exit 0
