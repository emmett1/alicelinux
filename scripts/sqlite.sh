#!/bin/sh

set -e

. /etc/pkg.conf
. /var/lib/pkg/functions

name=sqlite
version=3.33.0
_maj=${version%%.*}
_mid=${version#*.}
_mid=${_mid%%.*}
_min=${version##*.}
_version=${_maj}${_mid}0${_min}00
url="https://sqlite.org/2020/$name-autoconf-$_version.tar.gz"

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-autoconf-$_version

./configure --prefix=/usr --disable-static        \
			--enable-fts5 CFLAGS="$CFLAGS -g      \
			-DSQLITE_ENABLE_FTS3=1                \
			-DSQLITE_ENABLE_FTS4=1                \
			-DSQLITE_ENABLE_COLUMN_METADATA=1     \
			-DSQLITE_ENABLE_UNLOCK_NOTIFY=1       \
			-DSQLITE_SECURE_DELETE=1              \
			-DSQLITE_ENABLE_DBSTAT_VTAB=1         \
			-DSQLITE_ENABLE_FTS3_TOKENIZER=1"
make
make DESTDIR=$PKG install
        
xinstall

exit 0
