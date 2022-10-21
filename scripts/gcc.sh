#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=gcc
version=12.2.0

fetchunpack https://ftp.gnu.org/gnu/$name/$name-$version/$name-$version.tar.xz

cd $WORKDIR/$name-$version

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST --target=$TARGET"
fi

sed -e '/m64=/s/lib64/lib/' \
	-i.orig gcc/config/i386/t-linux64

# Do not run fixincludes
sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in

mkdir -v build
cd       build

SED=sed \
../configure $flags \
		 --prefix=/usr \
		 --libexecdir=/usr/lib \
		 --enable-languages=c,c++ \
		 --disable-bootstrap \
		 --disable-libmpx \
		 --with-system-zlib \
		 --disable-nls \
		 --disable-multilib \
		 --disable-libsanitizer
make
make -j1 DESTDIR=$PKG install

mkdir $PKG/lib
ln -sv ../usr/bin/cpp $PKG/lib/cpp
ln -sv gcc $PKG/usr/bin/cc

install -v -dm755 $PKG/usr/lib/bfd-plugins
ln -sfv ../../lib/gcc/$(${CC:-gcc} -dumpmachine)/$version/liblto_plugin.so \
		$PKG/usr/lib/bfd-plugins/

mkdir -pv $PKG/usr/share/gdb/auto-load/usr/lib
mv -v $PKG/usr/lib/*gdb.py $PKG/usr/share/gdb/auto-load/usr/lib

install -Dm755 $FILEDIR/c89 $PKG/usr/bin/c89
install -Dm755 $FILEDIR/c99 $PKG/usr/bin/c99

rm -fr $PKG/usr/share/$name-$version

pkginstall $version
