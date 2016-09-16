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
func=$2
lib=$3

sym=`echo $lib | tr -- '-.[a-z]' '__[A-Z]'`
have=

# Try to compile and link a short program which references this
# symbol. If the symbol exists in the library then this ought to
# succeed.
rm -f mp-check_lib
echo "char $func();int main(){(void)&$func;return 0;}" > mp-check_lib.c
echo "mp-check_lib.c:" >>config.log
cat mp-check_lib.c >>config.log
echo $CC $CFLAGS mp-check_lib.c -o mp-check_lib -l$lib $LIBS >>config.log
$CC $CFLAGS mp-check_lib.c -o mp-check_lib -l$lib $LIBS >>config.log 2>&1
if [ $? -eq 0 ]; then
    if [ -f mp-check_lib ]; then
	have=y
    fi
fi
rm -f mp-check_lib*

if [ "x$have" = "xy" ]; then
    echo "#define HAVE_LIB$sym 1" >> config.h
    echo "LIBS := \$(LIBS) -l$lib" >> config.mk
else
    if [ "x$require" = "xy" ]; then
	echo "configure: library $lib containing function $func is required"
	exit 1
    fi
    echo "/* #define HAVE_LIB$sym 1 */" >> config.h
    echo "# LIBS := \$(LIBS) -l$lib" >> config.mk
fi
