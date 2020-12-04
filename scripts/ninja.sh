#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

name=ninja
version=1.10.1
url=https://github.com/ninja-build/ninja/archive/v$version/ninja-$version.tar.gz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

python3 ./configure.py --bootstrap
install -Dm755 ninja $PKG/usr/bin/ninja

xinstall

exit 0
