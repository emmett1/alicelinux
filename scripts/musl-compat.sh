#!/bin/sh

set -e

. /etc/pkg.conf
. /var/lib/pkg/functions

name=musl-compat
version=1

mkdir -p $PKG/usr/bin $PKG/usr/include/sys
for i in getent getconf iconv; do
	${CC:-gcc} $CFLAGS $LDFLAGS -fpie $FILES_DIR/$i.c -o $PKG/usr/bin/$i
done

# bsdcompat headers
for h in tree.h queue.h cdefs.h; do
	install -D $FILES_DIR/$h $PKG/usr/include/sys/
done

xinstall

exit 0
