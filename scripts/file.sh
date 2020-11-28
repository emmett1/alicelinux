#!/bin/sh

set -e

if [ -f $(dirname $(dirname $(realpath $0)))/pkg.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/pkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/pkg.conf
	. /var/lib/pkg/functions
fi

name=file
version=5.39
url=ftp://ftp.astron.com/pub/$name/$name-$version.tar.gz

xfetch $url
xunpack $name-$version.tar.gz

cd $SRC/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST"
fi

./configure $flags \
	--prefix=/usr \
	--enable-fsect-man5 \
	--enable-static \
	--disable-libseccomp
make
make DESTDIR=$PKG install

xinstall $version

exit 0
