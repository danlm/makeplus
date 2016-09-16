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

library="$1"
soname="$1.$VERSION_MAJOR"
filename="$1.$VERSION_MAJOR.$VERSION_MINOR"

base_library=`basename "$library"`
base_soname=`basename "$soname"`
base_filename=`basename "$filename"`

install -m 0755 "$filename" "$DESTDIR$libdir"
cd "$DESTDIR$libdir"
rm -f "$base_soname" "$base_library"
ln -s "$base_filename" "$base_soname"
ln -s "$base_soname" "$base_library"
