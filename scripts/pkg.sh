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
version=20201202

cd $SRC

install -Dm644 $FILES_DIR/functions $PKG/var/lib/pkg/functions
install -Dm644 $FILES_DIR/pkg.conf $PKG/etc/pkg.conf
install -Dm755 $FILES_DIR/pkg $PKG/bin/pkg

install -d $PKG/etc
cat > $PKG/etc/pkg.conf << EOF
# configuration file for pkg

export CFLAGS="$CFLAGS"
export CXXFLAGS="\${CFLAGS}"
export MAKEFLAGS="$MAKEFLAGS"

#SOURCE_DIR="/var/lib/pkg/sources"
#WORK_DIR="/var/lib/pkg/work"
#LOG_DIR="/var/lib/pkg/log"
#FILES_DIR="/var/lib/pkg/files"
#SCRIPTS_DIR="/var/lib/pkg/scripts"
EOF

xinstall

exit 0
