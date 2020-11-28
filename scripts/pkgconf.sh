#!/bin/sh

set -e

if [ -f $(dirname $(dirname $(realpath $0)))/pkg.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/pkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/pkg.conf
	. /var/lib/pkg/functions
fi

name=pkgconf
version=1.7.3
url=http://distfiles.dereferenced.org/$name/$name-$version.tar.xz

xfetch $url
xunpack $name-$version.tar.xz

cd $SRC/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST"
fi

./configure $flags \
	--prefix=/usr \
	--sysconfdir=/etc \
	--with-pkg-config-dir="/usr/lib/pkgconfig:/usr/share/pkgconfig" \
	--with-system-libdir="/lib:/usr/lib" \
	--with-system-includedir="/usr/include"
make
make DESTDIR=$PKG install

ln -sf pkgconf "$PKG"/usr/bin/pkg-config

xinstall $version

exit 0
