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

# The user can add more exclude patterns by adding to or overriding
# this variable. Each pattern is a wildcard passed to the -X option
# of tar.
MP_DIST_EXCLUDE	= build-* makeplus-* CVS .\#* *~ *.old core

# Default name for the source distribution.
MP_SRC_DIST	= $(PACKAGE)-$(VERSION).tar.gz

# Default name for the binary distribution.
MP_BIN_DIST	= $(PACKAGE)-$(VERSION).bin.tar.gz

# Default name for the binary manifest.
MP_BIN_MANIFEST	= MANIFEST.bin

# If set then bundle a copy of make+ with source distributions.
# (Note: Doesn't work on platforms with losing non-GNU 'tar').
MP_BUNDLE	= 1

# Build a source distribution.
dist: mp-dist.ex
	rm -rf $(PACKAGE)-$(VERSION)
	rm -f $(MP_SRC_DIST)
	mkdir $(PACKAGE)-$(VERSION)
	tar -cf - -X mp-dist.ex $(EXTRA_DIST) -C .. . | \
	  tar -xf - -C $(PACKAGE)-$(VERSION)
	if [ -n "$(MP_BUNDLE)" -a -r "$(MAKEPLUS_HOME)/makeplus.tar.gz" ]; \
	then \
	  gzip -d -c $(MAKEPLUS_HOME)/makeplus.tar.gz | \
	  tar -xf - -C $(PACKAGE)-$(VERSION); \
	  cp $(MAKEPLUS_HOME)/README.make+_for_bundles \
	    $(PACKAGE)-$(VERSION)/README.make+; \
	fi
	tar -cf - $(PACKAGE)-$(VERSION) | gzip --best > $(MP_SRC_DIST)
	rm -rf $(PACKAGE)-$(VERSION)
	rm mp-dist.ex

mp-dist.ex:
	@for ex in $(MP_DIST_EXCLUDE); do echo $$ex; done > mp-dist.ex

# Build a binary distribution.
# XXX What's the standard name for this target?
bindist:
	rm -rf mp-bindist
	rm -f $(MP_BIN_DIST)
	mkdir mp-bindist
	$(MAKE) -f $(srcdir)/$(_mp_makefile) DESTDIR=mp-bindist install
	tar -cf - -C mp-bindist . | gzip --best > $(MP_BIN_DIST)
	rm -rf mp-bindist

# Build a manifest for the binary distribution.
mp_manifest_bin:
	rm -rf mp-bindist
	mkdir mp-bindist
	$(MAKE) -f $(srcdir)/$(_mp_makefile) DESTDIR=mp-bindist install
	find mp-bindist \! -type d | sed 's|^mp-bindist||' > $(MP_BIN_MANIFEST)
	rm -rf mp-bindist

.PHONY: dist bindist mp_manifest_bin
