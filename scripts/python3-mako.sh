#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: python3

name=python3-mako
version=1.1.3
url=https://files.pythonhosted.org/packages/source/M/Mako/Mako-$version.tar.gz

xfetch $url
xunpack ${url##*/}

cd $SRC/Mako-$version
python3 setup.py install --root=$PKG --optimize=1

xinstall

exit 0
