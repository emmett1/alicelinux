#!/bin/sh

set -e

. /etc/pkg.conf
. /var/lib/pkg/functions

#depends: perl

name=perl
version=5.32.0
url=https://www.cpan.org/src/5.0/$name-$version.tar.xz

xfetch $url
xunpack $name-$version.tar.xz

cd $SRC/$name-$version

sh Configure -des -Dprefix=/usr   \
	-Dvendorprefix=/usr           \
	-Dprivlib=/usr/lib/perl5/${version%.*} \
	-Dsitelib=/usr/lib/perl5/site_perl/${version%.*} \
	-Dvendorlib=/usr/lib/perl5/site_perl/${version%.*} \
	-Dman1dir=/usr/share/man/man1 \
	-Dman3dir=/usr/share/man/man3 \
	-Dpager="/usr/bin/less -isR"  \
	-Duseshrplib                  \
	-Dusethreads
make
make DESTDIR=$PKG install

xinstall $version

exit 0
