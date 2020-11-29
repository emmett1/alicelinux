#!/bin/sh

set -e

if [ -f $(dirname $(dirname $(realpath $0)))/main.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/main.conf
	. $(dirname $(dirname $(realpath $0)))/pkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/pkg.conf
	. /var/lib/pkg/functions
fi

name=busybox
version=1.32.0
url=https://www.busybox.net/downloads/$name-$version.tar.bz2

xfetch $url
xunpack $name-$version.tar.bz2

cd $SRC/$name-$version

if [ "$BOOTSTRAP" ]; then
	crossopt="ARCH=$CARCH CROSS_COMPILE=$TARGET-"
fi

#cp $SRC/config .config
make defconfig $crossopt
make $crossopt
make $crossopt CONFIG_PREFIX="$PKG" install
#install -Dm0755 busybox $PKG/bin/busybox

# conflict
rm $PKG/usr/bin/strings

xinstall $version

exit 0
