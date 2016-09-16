#!/bin/sh
#
# This is make+. Make+ is a set of scripts which enhance GNU make and
# let ou build RPMs, and other packages types with just one control
# file. Read more at http://www.annexia.org/freeware/makeplus/
#
# The original author is Richard W.M. Jones <rich@annexia.org>.
#
# This software has been explicitly placed in the PUBLIC DOMAIN.  You
# do not need any sort of license or agreement to use or copy this
# software. You may also copyright this software yourself, and/or
# relicense it under any terms you want, at any time and at no cost.
# This allows you (among other things) to include this software with
# other packages so that the user does not need to download and
# install make+ separately.

set -e

# Check the 'config.mk' file doesn't exist. If it does exist then this
# is a serious problem because it will override command line arguments
# (which, when doing a configure, we want). The user really ought to be
# running the ./configure shell script which removes this file.
if [ -f config.mk ]; then
    echo "configure: config.mk: file found (which is an error)"
    echo "configure: Before running 'make+ configure', you must remove this"
    echo "configure: file, or the build directory. You could also do:"
    echo "configure:   ./configure [--help]"
    exit 1
fi

rm -f config.h config.log

cat > config.h <<EOF
/* Generated automatically by make+. */

#ifndef MP_CONFIG_H
#define MP_CONFIG_H

#define PACKAGE "$PACKAGE"
#define VERSION "$VERSION"
EOF

cat > config.mk <<EOF
prefix		= $prefix
bindir		= $bindir
sbindir		= $sbindir
libexecdir	= $libexecdir
datadir		= $datadir
sysconfdir	= $sysconfdir
sharedstatedir	= $sharedstatedir
localstatedir	= $localstatedir
libdir		= $libdir
infodir		= $infodir
includedir	= $includedir
pkgdatadir	= $pkgdatadir
docdir		= $docdir
pkgetcdir	= $pkgetcdir
pkglibdir	= $pkglibdir
pkgincludedir	= $pkgincludedir
manprefix	= $manprefix
mandir		= $mandir
man1dir		= $man1dir
man2dir		= $man2dir
man3dir		= $man3dir
man4dir		= $man4dir
man5dir		= $man5dir
man6dir		= $man6dir
man7dir		= $man7dir
man8dir		= $man8dir
manndir		= $manndir
manldir		= $manldir
EOF
