#!/bin/sh -e

if [ -f $(dirname $(dirname $(realpath $0)))/xpkg.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/xpkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/xpkg.conf
	. /var/lib/pkg/functions
fi

name=linux
version=5.4.80
url=https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$version.tar.xz

xfetch $url
xunpack linux-$version.tar.xz

cd $SRC/linux-$version

if [ "$BOOTSTRAP" ]; then
	cross="ARCH=$CARCH"
fi

make $cross mrproper
make $cross INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
mkdir -p $PKG/usr/include
cp -rv dest/include/* $PKG/usr/include

xinstall

exit 0
