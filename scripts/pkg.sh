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

name=pkg
version=20200712

cd $SRC

install -Dm644 $FILES_DIR/functions $PKG/var/lib/pkg/functions
install -Dm644 $FILES_DIR/pkg.conf $PKG/etc/pkg.conf
install -Dm755 $FILES_DIR/pkg $PKG/bin/pkg

xinstall $version

exit 0
