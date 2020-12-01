#!/bin/sh

set -e

. /etc/pkg.conf
. /var/lib/pkg/functions

name=libffi
version=3.3
url=ftp://sourceware.org/pub/$name/$name-$version.tar.gz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

sed -e '/^includesdir/ s/$(libdir).*$/$(includedir)/' \
	-i include/Makefile.in

sed -e '/^includedir/ s/=.*$/=@includedir@/' \
	-e 's/^Cflags: -I${includedir}/Cflags:/' \
	-i libffi.pc.in

./configure --prefix=/usr --with-gcc-arch=x86-64
make
make DESTDIR=$PKG install

xinstall

exit 0
