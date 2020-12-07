#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: 

name=grub
version=2.04
url=https://ftp.gnu.org/gnu/$name/$name-$version.tar.xz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

#patch -Np1 -i $FILES_DIR/0006-BootHole.patch

./configure \
	--prefix=/usr \
	--sbindir=/sbin \
	--sysconfdir=/etc \
	--disable-efiemu \
	--disable-werror \
	--disable-nls
make
make DESTDIR=$PKG install

xinstall

exit 0
