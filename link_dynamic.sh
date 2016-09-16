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

# Find the name of the linker -soname option.
# XXX This is wrong: during the configure stage we should work out
# which Solaris linker we are using (gcc has it as a hard-coded path)
# and choose the appropriate option.
soname_opt=-soname
if [ `uname` = "SunOS" ]; then
    soname_opt=-h
fi

library="$1"; shift

soname="$library.$VERSION_MAJOR"
filename="$library.$VERSION_MAJOR.$VERSION_MINOR"

base_soname=`basename "$soname"`
base_filename=`basename "$filename"`

gcc -shared -Wl,$soname_opt,"$base_soname" -o "$filename" "$@"
rm -f "$soname" "$library"
ln -s "$base_filename" "$soname"
ln -s "$base_soname" "$library"
