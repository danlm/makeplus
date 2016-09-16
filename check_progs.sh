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

for prog in "$@"; do
    sym=`echo $prog | tr -- '-./[a-z]' '___[A-Z]'`
    have=

    # Find out if the program exists. The trick here is not to actually
    # run the program.
    if which $prog >> config.log 2>&1; then
	have=y
    fi

    if [ "x$have" = "xy" ]; then
	echo "#define HAVE_$sym 1" >> config.h
	echo "HAVE_$sym := 1" >> config.mk
    else
	if [ "x$require" = "xy" ]; then
	    echo "configure: program $prog is required; not found"
	    echo "configure: You may need to do:"
	    echo "configure:   PATH=/path/to/program:\$PATH; export PATH"
	    exit 1
	fi
	echo "/* #define HAVE_$sym 1 */" >> config.h
	echo "# HAVE_$sym := 1" >> config.h
    fi
done
