#!/bin/sh

set -e

if [ -f $(dirname $(dirname $(realpath $0)))/main.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/main.conf
	. $(dirname $(dirname $(realpath $0)))/pkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/pkg.conf
	. /var/lib/pkg/functions
fi

name=musl
version=1.2.1
url=https://musl.libc.org/releases/musl-$version.tar.gz

xfetch $url
xunpack $name-$version.tar.gz

cd $SRC/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST --target=$TARGET"
fi

./configure $flags \
	--prefix=/usr
make
make DESTDIR=$PKG install

mkdir -p $PKG/usr/bin
ln -sf ../lib/libc.so $PKG/usr/bin/ldd
mkdir -p $PKG/sbin
#ln -sv /bin/true $PKG/sbin/ldconfig

xinstall $version

exit 0
