#!/bin/sh

set -e

if [ -f $(dirname $(dirname $(realpath $0)))/pkg.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/pkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/pkg.conf
	. /var/lib/pkg/functions
fi

name=mpc
version=1.2.1
url=https://ftp.gnu.org/gnu/mpc/mpc-$version.tar.gz

xfetch $url
xunpack $name-$version.tar.gz

cd $SRC/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST --target=$TARGET"
fi

./configure $flags \
	--prefix=/usr    \
	--disable-static
make
make DESTDIR=$PKG install

xinstall $version

exit 0
