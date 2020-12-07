#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: zlib

name=zstd
version=1.4.5
url=https://github.com/facebook/zstd/releases/download/v$version/$name-$version.tar.gz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

make
make PREFIX=/usr DESTDIR=$PKG install

xinstall

exit 0
