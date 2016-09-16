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

# Build an RPM
rpm:	mp-rpm.spec
	@rm -rf mp-rpm
	@mkdir mp-rpm
	@mkdir mp-rpm/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
	@mkdir mp-rpm/RPMS/{i386,i486,i586,i686,noarch}
	$(MAKE) -f $(srcdir)/$(_mp_makefile) \
	  MP_SRC_DIST=mp-rpm/SOURCES/$(PACKAGE)-$(VERSION).tar.gz dist
	@cp mp-rpm.spec mp-rpm/SPECS/$(PACKAGE)-$(VERSION).spec
	rpmbuild -ba --define _topdir\ `pwd`/mp-rpm --clean \
	mp-rpm/SPECS/$(PACKAGE)-$(VERSION).spec
	@mv mp-rpm/RPMS/*/*.rpm mp-rpm/SRPMS/*.rpm .
	@rm -rf mp-rpm mp-rpm.spec

# Build the spec file.
mp-rpm.spec: $(srcdir)/$(_mp_makefile)
	$(MAKE) -f $< prefix=/usr sysconfdir=/etc localstatedir=/var \
	  MP_BIN_MANIFEST=mp-MANIFEST.bin mp_manifest_bin
	$(MAKEPLUS_HOME)/make_rpm_spec.sh mp-MANIFEST.bin > $@
	@rm mp-MANIFEST.bin

.PHONY: rpm