#!/bin/sh -e

. /etc/xpkg.conf
. /var/lib/pkg/functions

#depends: python3

name=python3-setuptools
version=50.3.2
url=https://github.com/pypa/setuptools/archive/v$version/$name-$version.tar.gz

xfetch $url
xunpack ${url##*/}

cd $SRC/setuptools-$version

export SETUPTOOLS_INSTALL_WINDOWS_SPECIFIC_FILES=0
python3 bootstrap.py
python3 setup.py build
python3 setup.py install --prefix=/usr --root="$PKG" --optimize=1 --skip-build

xinstall

exit 0
