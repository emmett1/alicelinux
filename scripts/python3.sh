#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: libffi sqlite expat

name=python3
version=3.8.5
url=https://www.python.org/ftp/python/$version/Python-$version.tar.xz

xfetch $url
xunpack ${url##*/}

cd $SRC/Python-$version

./configure \
	--prefix=/usr \
	--enable-shared \
	--with-system-expat \
	--with-system-ffi \
	--without-ensurepip \
	--without-doc-strings
make
make DESTDIR=$PKG install

chmod -v 755 $PKG/usr/lib/libpython${version%.*}.so
chmod -v 755 $PKG/usr/lib/libpython3.so

rm -rf $PKG/usr/lib/python${version%.*}/test
rm -rf $PKG/usr/lib/python${version%.*}/*/test
rm -rf $PKG/usr/lib/python${version%.*}/*/tests
rm -rf $PKG/usr/lib/python${version%.*}/pydoc*

xinstall

exit 0
