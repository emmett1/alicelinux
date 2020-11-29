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

name=rsync
version=3.2.3
url=https://www.samba.org/ftp/rsync/src/$name-$version.tar.gz

xfetch $url
xunpack $name-$version.tar.gz

cd $SRC/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST --disable-simd"
fi

./configure $flags \
	--prefix=/usr \
	--with-included-popt=no \
	--with-included-zlib=no \
	--disable-xxhash \
	--disable-zstd \
	--disable-lz4
make
make DESTDIR=$PKG install

xinstall $version

exit 0
