#!/bin/sh -e

cd $(dirname $0) ; CWD=$(pwd); . $CWD/functions

name=filesystem
version=1

#  root dirs
for d in dev proc sys run bin boot etc/opt home lib mnt \
	opt sbin srv var run; do
	mkdir -p $PKG/$d
done
install -d -m 555 $PKG/proc
install -d -m 555 $PKG/sys
install -d -m 0750 $PKG/root
install -d -m 1777 $PKG/tmp $PKG/var/tmp

# /usr and /usr/local dirs
for d in bin include lib sbin src; do
	mkdir -p $PKG/usr/$d
	#mkdir -p $PKG/usr/local/$d
done

# man page dirs
for d in 1 2 3 4 5 6 7 8; do
	mkdir -p $PKG/usr/share/man/man$d
	#mkdir -p $PKG/usr/local/share/man/man$d
done

# /var dirs
for d in log mail spool opt cache lib/misc; do
	mkdir -p $PKG/var/$d
done

ln -s ../run $PKG/var/run
ln -s ../run/lock $PKG/var/lock

ln -s /proc/self/mounts $PKG/etc/mtab

# log files
for f in btmp lastlog faillog wtmp; do
	touch $PKG/var/log/$f
done
#chgrp utmp $PKG/var/log/lastlog
chmod 664  $PKG/var/log/lastlog
chmod 600  $PKG/var/log/btmp

#mknod -m 600 $PKG/dev/console c 5 1
#mknod -m 666 $PKG/dev/null c 1 3

cd $FILEDIR
install -m644 passwd $PKG/etc
install -m644 group $PKG/etc
#install -m644 resolv.conf $PKG/etc
install -m644 locale.conf $PKG/etc
install -m644 hosts $PKG/etc
#install -m644 hostname $PKG/etc
install -m644 shells $PKG/etc
install -m644 fstab $PKG/etc
#install -m644 lsb-release $PKG/etc
#install -m644 os-release $PKG/etc
install -m644 profile $PKG/etc

install -dm0755 $PKG/etc/profile.d
install -m644 locale.sh $PKG/etc/profile.d

install -d $PKG/etc/init.d
install -m755 rcS $PKG/etc/init.d
install -m644 inittab $PKG/etc

pkginstall $version
