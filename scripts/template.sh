#!/bin/sh
#
# an example package build script
#
set -e

# sourcing required configs and functions
. /etc/pkg.conf
. /var/lib/pkg/functions

# define dependencies here, it will automatically solved by pkg
#depends: dep1 dep2 dep3

# package details
# 'version' is required for package track into database. '0' is used if version is empty.
name=
version=
url=

# use 'xfetch <url>' to fetch source into $SOURCE_DIR
xfetch $url

# use 'xunpack <tarball name>' to extract source tarball into $SRC
xunpack ${url##*/}

# start your package build here
# $SRC is where source tarball is extracted
# $PKG is where package files should installed
cd $SRC/$name-$version

./configure \
	 --prefix=/usr
make
make DESTDIR=$PKG install

# use 'xinstall' to install (rsync-ed) all files in $PKG into real system
xinstall

exit 0
