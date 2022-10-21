#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=gcc
version=12.2.0
gmp_ver=6.2.1
mpfr_ver=4.1.0
mpc_ver=1.2.1

fetchunpack https://ftp.gnu.org/gnu/$name/$name-$version/$name-$version.tar.xz
fetchunpack https://ftp.gnu.org/gnu/gmp/gmp-$gmp_ver.tar.xz
fetchunpack https://www.mpfr.org/mpfr-$mpfr_ver/mpfr-$mpfr_ver.tar.xz
fetchunpack https://ftp.gnu.org/gnu/mpc/mpc-$mpc_ver.tar.gz

cd $WORKDIR/$name-$version

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
	--prefix="$CROSSTOOL" \
	--target="$TARGET" \
	--build="$HOST" \
	--host="$HOST" \
	--libexecdir="$CROSSTOOL"/lib \
	--with-sysroot="$ROOTFS" \
	--with-local-prefix="$ROOTFS" \
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

rm -fr $WORKDIR $PKG
