#!/bin/sh -e

if [ -f $(dirname $(dirname $(realpath $0)))/xpkg.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/xpkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/xpkg.conf
	. /var/lib/pkg/functions
fi

#depends: gperf

name=eudev
version=3.2.9
url=https://dev.gentoo.org/~blueness/$name/$name-$version.tar.gz

xfetch $url
xunpack $name-$version.tar.gz

cd $SRC/$name-$version

./configure --prefix=/usr           \
			--bindir=/sbin          \
			--sbindir=/sbin         \
			--libdir=/usr/lib       \
			--sysconfdir=/etc       \
			--libexecdir=/lib       \
			--with-rootprefix=      \
			--with-rootlibdir=/lib  \
			--enable-manpages       \
			--disable-static
make

mkdir -pv $PKG/lib/udev/rules.d
mkdir -pv $PKG/etc/udev/rules.d

make DESTDIR=$PKG install

xinstall

exit 0
