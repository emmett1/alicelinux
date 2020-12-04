#!/bin/sh -e

if [ -f $(dirname $(dirname $(realpath $0)))/xpkg.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/xpkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/xpkg.conf
	. /var/lib/pkg/functions
fi

sety() {
	while [ "$1" ]; do
		sed -i "s/# CONFIG_$1 is not set/CONFIG_$1=y/" .config
		shift
	done
}

setn() {
	while [ "$1" ]; do
		sed -i "s/CONFIG_$1=y/# CONFIG_$1 is not set/" .config
		shift
	done
}

name=busybox
version=1.32.0
url=https://www.busybox.net/downloads/$name-$version.tar.bz2

xfetch $url
xunpack $name-$version.tar.bz2

cd $SRC/$name-$version

if [ "$BOOTSTRAP" ]; then
	crossopt="ARCH=$CARCH CROSS_COMPILE=$TARGET-"
fi

make defconfig $crossopt

setn LINUXRC STRINGS

make $crossopt
make $crossopt CONFIG_PREFIX="$PKG" install

install -d $PKG/usr/share/$name
cp .config $PKG/usr/share/$name/config

xinstall

exit 0
