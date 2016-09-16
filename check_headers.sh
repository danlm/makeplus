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

require=$1
shift

for hdr in "$@"; do
    sym=`echo $hdr | tr -- '-./[a-z]' '___[A-Z]'`
    have=

    # Try to compile a short program which includes this file.
    rm -f mp-check_header.o
    echo "#include <$hdr>" > mp-check_header.c
    echo "mp-check_header.c:" >>config.log
    cat mp-check_header.c >>config.log
    echo $CC $CFLAGS -E mp-check_header.c >>config.log
    $CC $CFLAGS -E mp-check_header.c >>config.log 2>&1
    if [ $? -eq 0 ]; then
        have='y'
    fi
    rm -f mp-check_header*

    if [ "x$have" = "xy" ]; then
	echo "#define HAVE_$sym 1" >> config.h
	echo "HAVE_$sym := 1" >> config.mk
    else
	if [ "x$require" = "xy" ]; then
	    echo "configure: header file <$hdr> is required; not found"
	    echo "configure: You may need to do:"
	    echo "configure:   CFLAGS=-I/path/to/header; export CFLAGS"
	    exit 1
	fi
	echo "/* #define HAVE_$sym 1 */" >> config.h
	echo "# HAVE_$sym := 1" >> config.mk
    fi
done
