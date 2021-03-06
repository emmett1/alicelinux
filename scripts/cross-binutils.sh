#!/bin/sh -e

if [ -f $(dirname $(dirname $(realpath $0)))/xpkg.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/xpkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/xpkg.conf
	. /var/lib/pkg/functions
fi

name=binutils
version=2.35.1
url=https://ftp.gnu.org/gnu/binutils/$name-$version.tar.xz

xfetch $url
xunpack $name-$version.tar.xz

cd $SRC/$name-$version

mkdir build
cd build

../configure \
	--prefix="$TCDIR" \
	--target="$TARGET" \
	--with-sysroot="$ROOT_DIR" \
	--disable-nls \
	--disable-multilib
make configure-host
make
make install

xinstall

exit 0
