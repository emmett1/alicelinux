#!/bin/sh -e

if [ -f $(dirname $(dirname $(realpath $0)))/xpkg.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/xpkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/xpkg.conf
	. /var/lib/pkg/functions
fi

name=pkg
version=20201207

cd $SRC

install -Dm644 $FILES_DIR/functions $PKG/var/lib/pkg/functions
install -Dm755 $FILES_DIR/xpkg $PKG/bin/xpkg
install -Dm755 $FILES_DIR/scriptupdate $PKG/bin/scriptupdate

install -d $PKG/etc
cat > $PKG/etc/xpkg.conf << EOF
# configuration file for xpkg

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
