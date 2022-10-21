#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=
version=

fetchunpack 

cd $WORKDIR/$name-$version

pkginstall $version
