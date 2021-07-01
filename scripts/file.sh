#!/bin/sh -e

if [ -f $(dirname $(dirname $(realpath $0)))/xpkg.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/xpkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/xpkg.conf
	. /var/lib/pkg/functions
fi

name=file
version=5.39
url=ftp://ftp.astron.com/pub/$name/$name-$version.tar.gz

xfetch $url
xunpack $name-$version.tar.gz

cd $SRC/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST"
fi

# Local build
mkdir -p build
pushd build
CC="" \
CXX="" \
AS="" \
AR="" \
LD="" \
RANLIB="" \
../configure --disable-bzlib \
	--disable-libseccomp \
	--disable-xzlib \
	--disable-zlib
popd

./configure $flags \
	--prefix=/usr \
	--enable-fsect-man5 \
	--enable-static \
	--disable-libseccomp
make FILE_COMPILE=$(pwd)/build/src/file
make DESTDIR=$PKG install

xinstall

exit 0
