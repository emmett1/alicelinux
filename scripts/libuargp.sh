#!/bin/sh

set -e

. /etc/pkg.conf
. /var/lib/pkg/functions

name=libuargp
version=20200713
_commit=b9f1d59279eef0a79853867745036b018f2b2348
url=https://github.com/xhebox/libuargp/archive/$_commit.tar.gz

xfetch $url
xunpack $_commit.tar.gz

cd $SRC/$name-$_commit
make
make prefix=/usr DESTDIR=$PKG install

xinstall

exit 0
