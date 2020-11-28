#!/bin/sh

set -e

if [ -f $(dirname $(dirname $(realpath $0)))/pkg.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/pkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/pkg.conf
	. /var/lib/pkg/functions
fi

#depends: m4

name=gmp
version=6.2.1
url=https://ftp.gnu.org/gnu/gmp/$name-$version.tar.xz

xfetch $url
xunpack $name-$version.tar.xz

cd $SRC/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET"
fi

./configure $flags \
	--prefix=/usr \
	--enable-cxx \
	--build=${HOST:-x86_64-pc-linux-musl} \
	--disable-static
make
make DESTDIR=$PKG install

xinstall $version

exit 0
