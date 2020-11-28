#!/bin/sh

set -e

if [ -f $(dirname $(dirname $(realpath $0)))/pkg.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/pkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/pkg.conf
	. /var/lib/pkg/functions
fi

name=gperf
version=3.1
url=https://ftp.gnu.org/gnu/gperf/$name-$version.tar.gz

xfetch $url
xunpack $name-$version.tar.gz

cd $SRC/$name-$version

./configure --prefix=/usr
make
make DESTDIR=$PKG install

xinstall $version

exit 0
