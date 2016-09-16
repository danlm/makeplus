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

# This module contains code for building a website and uploading
# a whole release (source, binary, RPMs, website, etc.) to your server.

# mp_release is the main target. It builds everything and uploads it.
# The only thing you need to do is change the version number before
# running it.
mp_release:
	cd $(srcdir) && $(MAKEPLUS_HOME)/release.sh

# This target just rebuilds the website (index.html).
mp_website: index.html

index.html: $(srcdir)/$(_mp_makefile)
	$(MAKEPLUS_HOME)/make_website.sh > $@

.PHONY: mp_release mp_website
