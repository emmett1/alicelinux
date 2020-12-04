#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: bzip2

name=libarchive
version=3.5.0
url=https://github.com/libarchive/libarchive/releases/download/v$version/libarchive-$version.tar.gz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

./configure \
	--prefix=/usr \
	--without-xml2 \
	--without-nettle \
	--without-lz4 \
	--without-zstd \
	--without-openssl \
	--disable-static
make
make DESTDIR=$PKG install

xinstall

exit 0
