#!/bin/sh

set -e

if [ -f $(dirname $(dirname $(realpath $0)))/main.conf ]; then
	. $(dirname $(dirname $(realpath $0)))/main.conf
	. $(dirname $(dirname $(realpath $0)))/crosspkg.conf
	. $(dirname $(dirname $(realpath $0)))/files/functions
else
	. /etc/pkg.conf
	. /var/lib/pkg/functions
fi

name=gcc
version=10.2.0
gmp_ver=6.2.1
mpfr_ver=4.1.0
mpc_ver=1.2.1
url=https://ftp.gnu.org/gnu/$name/$name-$version/$name-$version.tar.xz
url1=https://ftp.gnu.org/gnu/gmp/gmp-$gmp_ver.tar.xz
url2=https://www.mpfr.org/mpfr-$mpfr_ver/mpfr-$mpfr_ver.tar.xz
url3=https://ftp.gnu.org/gnu/mpc/mpc-$mpc_ver.tar.gz

xfetch $url
xfetch $url1
xfetch $url2
xfetch $url3
xunpack $name-$version.tar.xz
xunpack gmp-$gmp_ver.tar.xz
xunpack mpfr-$mpfr_ver.tar.xz
xunpack mpc-$mpc_ver.tar.gz

cd $SRC/$name-$version

mv ../gmp-$gmp_ver gmp
mv ../mpfr-$mpfr_ver mpfr
mv ../mpc-$mpc_ver mpc

sed -e '/m64=/s/lib64/lib/' \
	-i.orig gcc/config/i386/t-linux64

# Do not run fixincludes
sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in

mkdir build
cd build

../configure \
	--prefix="$TCDIR" \
	--target="$TARGET" \
	--build="$HOST" \
	--host="$HOST" \
	--libexecdir="$TCDIR"/lib \
	--with-sysroot="$ROOT_DIR" \
	--with-local-prefix="$ROOT_DIR" \
	--with-native-system-header-dir="/usr/include" \
	--disable-nls \
	--disable-shared \
	--without-headers \
	--disable-multilib \
	--disable-decimal-float \
	--disable-libgomp \
	--disable-libmudflap \
	--disable-libssp \
	--disable-libatomic \
	--disable-libquadmath \
	--disable-threads \
	--enable-languages=c \
	--with-newlib
make all-gcc all-target-libgcc
make -j1 install-gcc install-target-libgcc

[ $PIPESTATUS = 0 ] || exit 1

xinstall

exit 0
