#!/bin/sh

set -e

. /etc/pkg.conf
. /var/lib/pkg/functions

#depends: musl-compat

name=elfutils
version=0.182
url=https://sourceware.org/ftp/elfutils/$version/elfutils-$version.tar.bz2

xfetch $url
xunpack $name-$version.tar.bz2

cd $SRC/$name-$version

cp $FILES_DIR/error.h lib
cp $FILES_DIR/error.h src

# Disable configure error for missing argp. (thanks to kisslinux)
sed -i 's/as_fn_error.*libargp/: "/g' configure

# Don't compile two unrelated C files which require argp. (thanks to kisslinux)
sed -i 's/color.*printversion../#/g' lib/Makefile.in

CFLAGS="$CFLAGS -Wno-error -Wno-null-dereference -DFNM_EXTMATCH=0"
./configure \
	--prefix=/usr \
	--program-prefix="eu-" \
	--disable-nls \
	--disable-debuginfod \
	--disable-libdebuginfod \
	--enable-deterministic-archives
make -C lib
make -C libelf
make -C libelf DESTDIR="$PKG" install

mkdir -p "$PKG/usr/lib/pkgconfig"
cp -f config/libelf.pc "$PKG/usr/lib/pkgconfig/libelf.pc"

xinstall

exit 0
