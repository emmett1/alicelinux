#!/bin/sh

set -e

if [ -f $(dirname $(dirname $(realpath $0)))/pkg.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/pkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/pkg.conf
	. /var/lib/pkg/functions
fi

name=m4
version=1.4.18
url=https://ftp.gnu.org/gnu/$name/$name-$version.tar.xz

xfetch $url
xunpack $name-$version.tar.xz

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST"
fi

cd $SRC/$name-$version

./configure $flags --prefix=/usr
make
make DESTDIR=$PKG install

xinstall $version

exit 0
