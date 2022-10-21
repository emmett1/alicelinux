#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=binutils
version=2.39

fetchunpack https://ftp.gnu.org/gnu/binutils/$name-$version.tar.xz

cd $WORKDIR/$name-$version

patch -Np1 -i $FILEDIR/binutils-2.39-musl-fix.patch

if [ "$BOOTSTRAP" ]; then
	flags="--host=$TARGET --build=$HOST --target=$TARGET --with-sysroot=$ROOT_DIR"
fi

sed -i '/^SUBDIRS/s/doc//' bfd/Makefile.in

mkdir -v build
cd       build

# thanks to kisslinux
cat > makeinfo <<EOF
#!/bin/sh
printf 'makeinfo (GNU texinfo) 5.2\n'
EOF

chmod +x makeinfo
export PATH=$PATH:$PWD

../configure $flags \
	 --prefix=/usr       \
	 --enable-gold       \
	 --disable-nls       \
	 --enable-ld=default \
	 --enable-plugins    \
	 --enable-shared     \
	 --disable-werror    \
	 --with-system-zlib  \
	 --disable-multilib  \
	 --with-lib-path=/usr/lib:/lib
make tooldir=/usr
make tooldir=/usr -j1 DESTDIR=$PKG install

pkginstall $version
