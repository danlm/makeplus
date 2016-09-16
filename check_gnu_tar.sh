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

# XXX More thought required here. Much of dist.mk makes assumptions
# that we have a non-losing tar. This is why you can't build distributions
# on Solaris yet.

tar --help > mp-check_gnu_tar 2>&1
if head -1 mp-check_gnu_tar | grep -q GNU >/dev/null 2>&1; then
    echo 'HAVE_GNU_TAR := 1' >> config.mk
    echo '#define HAVE_GNU_TAR 1' >> config.h
else
    echo '# HAVE_GNU_TAR := 1' >> config.mk
    echo '/* #define HAVE_GNU_TAR 1 */' >> config.h
fi
rm -f mp-check_gnu_tar
