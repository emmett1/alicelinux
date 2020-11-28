#!/bin/sh

set -e

if [ -f $(dirname $(dirname $(realpath $0)))/pkg.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/pkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/pkg.conf
	. /var/lib/pkg/functions
fi

name=zlib
version=1.2.11
url=https://zlib.net/$name-$version.tar.xz

xfetch $url
xunpack $name-$version.tar.xz

cd $SRC/$name-$version

if [ "$BOOTSTRAP" ]; then
	export CHOST=$TARGET
	export CC=$CC
fi

./configure --prefix=/usr
make
make DESTDIR=$PKG install

mkdir -p $PKG/lib
mv -v $PKG/usr/lib/libz.so.* $PKG/lib
ln -sfv ../../lib/$(readlink $PKG/usr/lib/libz.so) $PKG/usr/lib/libz.so

xinstall $version

exit 0
