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

name=binutils
version=2.35.1
url=https://ftp.gnu.org/gnu/binutils/$name-$version.tar.xz

xfetch $url
xunpack $name-$version.tar.xz

cd $SRC/$name-$version

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
make tooldir=/usr DESTDIR=$PKG install

xinstall

exit 0
