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

# General C compilation variables.
CC		?= gcc
CFLAGS		+= -I. -I..
LIBS		+=
SETENV		?= /usr/bin/env
CONF_ENV	= CC="$(CC)" CFLAGS="$(CFLAGS)"

# Link scripts.
MP_LINK_STATIC	= $(MAKEPLUS_HOME)/link_static.sh
MP_LINK_DYNAMIC	= $(MAKEPLUS_HOME)/link_dynamic.sh
MP_INSTALL_STATIC_LIB = $(MAKEPLUS_HOME)/install_static_lib.sh
MP_INSTALL_DYNAMIC_LIB = $(MAKEPLUS_HOME)/install_dynamic_lib.sh

# Compile object files for dynamic linking.
.c.lo:
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

.SUFFIXES: .lo