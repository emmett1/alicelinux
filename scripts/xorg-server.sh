#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: pixman libdrm

name=xorg-server
version=1.20.9
url=http://ftp.x.org/pub/individual/xserver/$name-$version.tar.bz2

xfetch $url
xunpack $name-$version.tar.bz2

cd $SRC/$name-$version

./configure \
	 --prefix=/usr \
	 --sysconfdir=/etc \
	 --localstatedir=/var \
	 --libexecdir=/usr/lib/$name \
	 --disable-static \
	 --enable-glamor \
	 --enable-suid-wrapper \
	 --with-xkb-output=/var/lib/xkb
make
make DESTDIR=$PKG install

mkdir -pv $PKG/etc/X11/xorg.conf.d

xinstall

exit 0
