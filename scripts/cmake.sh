#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: bzip2

name=cmake
version=3.19.1
url=https://www.cmake.org/files/v${version%.*}/$name-$version.tar.gz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

sed -i '/"lib64"/s/64//' Modules/GNUInstallDirs.cmake

./configure \
        --prefix=/usr \
        --system-curl \
        --system-expat \
        --system-zlib \
        --system-bzip2
make
make DESTDIR=$PKG install

rm -r $PKG/usr/doc
rm -r $PKG/usr/share/cmake-*/Help
	
xinstall

exit 0
