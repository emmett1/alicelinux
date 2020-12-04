#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

name=bzip2
version=1.0.8
url=https://www.sourceware.org/pub/bzip2/$name-$version.tar.gz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

# use our optimization
[ "${CFLAGS}" ] && sed -i "s|-O2|${CFLAGS}|g" Makefile
[ "${CFLAGS}" ] && sed -i "s|-O2|${CFLAGS}|g" Makefile-libbz2_so

make -f Makefile-libbz2_so
make
make PREFIX=$PKG/usr install

mkdir -pv $PKG/bin \
		  $PKG/lib \
		  $PKG/usr/lib

cp -v bzip2-shared $PKG/bin/bzip2
cp -av libbz2.so* $PKG/lib
ln -sv ../../lib/libbz2.so.1.0 $PKG/usr/lib/libbz2.so
rm -v $PKG/usr/bin/bunzip2 \
	  $PKG/usr/bin/bzcat \
	  $PKG/usr/bin/bzip2
ln -sv bzip2 $PKG/bin/bunzip2
ln -sv bzip2 $PKG/bin/bzcat

xinstall

exit 0
