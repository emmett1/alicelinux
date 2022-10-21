#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

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

fetchunpack https://www.busybox.net/downloads/$name-$version.tar.bz2

cd $WORKDIR/$name-$version

if [ "$BOOTSTRAP" ]; then
	crossopt="ARCH=$CARCH CROSS_COMPILE=$TARGET-"
fi

make defconfig $crossopt

setn LINUXRC STRINGS

make $crossopt
make $crossopt CONFIG_PREFIX="$PKG" install

install -d $PKG/usr/share/$name
cp .config $PKG/usr/share/$name/config

pkginstall $version
