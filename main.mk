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

# This is a hack to make GNU make recognise '_mp_all (all)' as the
# default goal.
include $(MAKEPLUS_HOME)/default_goal.mk

# Set the VPATH because builds always happen in a subdirectory.
VPATH		:= ..
srcdir		:= $(shell cd .. && pwd)

# Directories.
prefix		?= /usr/local
bindir		= $(prefix)/bin
sbindir		= $(prefix)/sbin
libexecdir	= $(prefix)/libexec
datadir		= $(prefix)/share
sysconfdir	= $(prefix)/etc
sharedstatedir	= $(prefix)/com
localstatedir	= $(prefix)/var
libdir		= $(prefix)/lib
infodir		= $(prefix)/info
includedir	= $(prefix)/include
pkgdatadir	= $(datadir)/$(PACKAGE)
docdir		= $(datadir)/doc/$(PACKAGE)-$(VERSION)
pkgetcdir	= $(sysconfdir)/$(PACKAGE)
pkglibdir	= $(libdir)/$(PACKAGE)
pkgincludedir	= $(includedir)/$(PACKAGE)
ifneq ($(shell uname), FreeBSD)
manprefix	= $(datadir)
else
manprefix	= $(prefix)
endif
mandir		= $(manprefix)/man
man1dir		= $(mandir)/man1
man2dir		= $(mandir)/man2
man3dir		= $(mandir)/man3
man4dir		= $(mandir)/man4
man5dir		= $(mandir)/man5
man6dir		= $(mandir)/man6
man7dir		= $(mandir)/man7
man8dir		= $(mandir)/man8
manndir		= $(mandir)/mann
manldir		= $(mandir)/manl

# If the configuration file exists, include it (from the build directory).
-include config.mk

# Include the other parts of this makefile.
include $(MAKEPLUS_HOME)/configure.mk
include $(MAKEPLUS_HOME)/c.mk
include $(MAKEPLUS_HOME)/dist.mk
include $(MAKEPLUS_HOME)/rpm.mk
include $(MAKEPLUS_HOME)/test.mk
include $(MAKEPLUS_HOME)/website.mk

# Clean rule (removes files and links in the build directory and removes
# editor backup files from the source directory).
clean:
	[ -f $(srcdir)/$(_mp_makefile) ]
	find . \( -type f -o -type l \) -print | xargs rm -f
	find .. -name '*~' -print | xargs rm -f

# Distclean rule (does a clean and additionally removes the build directory).
distclean: clean
	cd .. && rm -rf $(_mp_builddir)

# Force target.
_mp_force:

# Export everything.
.EXPORT_ALL_VARIABLES:

# Phony targets.
.PHONY: clean configure distclean
