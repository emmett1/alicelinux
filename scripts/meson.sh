#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: python3-setuptools ninja

name=meson
version=0.56.0
url=https://github.com/mesonbuild/meson/releases/download/$version/$name-$version.tar.gz

xfetch $url
xunpack ${url##*/}

cd $SRC/$name-$version

python3 setup.py build
python3 setup.py install --root=$PKG

xinstall

exit 0
