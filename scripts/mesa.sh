#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: python3-mako llvm elfutils bison flex libxext libxdamage libxshmfence libxxf86vm libxrandr

name=mesa
version=20.2.3
url=https://archive.mesa3d.org/mesa-$version.tar.xz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

patch -Np1 -i $FILES_DIR/0001-musl.patch
patch -Np1 -i $FILES_DIR/glx-tls.patch

mkdir build
cd    build

meson --prefix=/usr \
	  --sysconfdir=/etc \
	  -Dvalgrind=false \
	  -Dglx=dri \
	  -Degl=enabled \
	  -Dosmesa=gallium \
	  -Dgallium-nine=true \
	  -Dplatforms=drm,x11 \
	  -Dglvnd=true \
	  -Dllvm=true \
	  -Delf-use-tls=false \
	  ..
ninja
DESTDIR=$PKG ninja install

xinstall

exit 0
