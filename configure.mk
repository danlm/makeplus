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

# Configuration scripts.
MP_CONFIGURE_START = $(SETENV) $(CONF_ENV) $(MAKEPLUS_HOME)/configure_start.sh
MP_CONFIGURE_END = $(SETENV) $(CONF_ENV) $(MAKEPLUS_HOME)/configure_end.sh

MP_CHECK_HEADERS = $(SETENV) $(CONF_ENV) $(MAKEPLUS_HOME)/check_headers.sh n
MP_CHECK_HEADER = $(MP_CHECK_HEADERS)
MP_CHECK_FUNCS	=  $(SETENV) $(CONF_ENV) $(MAKEPLUS_HOME)/check_funcs.sh n
MP_CHECK_LIB	=  $(SETENV) $(CONF_ENV) $(MAKEPLUS_HOME)/check_lib.sh n
MP_CHECK_PROGS	=  $(SETENV) $(CONF_ENV) $(MAKEPLUS_HOME)/check_progs.sh n
MP_CHECK_PROG	=  $(MP_CHECK_PROGS)
MP_REQUIRE_HEADERS = $(SETENV) $(CONF_ENV) $(MAKEPLUS_HOME)/check_headers.sh y
MP_REQUIRE_HEADER = $(MP_REQUIRE_HEADERS)
MP_REQUIRE_FUNCS = $(SETENV) $(CONF_ENV) $(MAKEPLUS_HOME)/check_funcs.sh y
MP_REQUIRE_LIB	= $(SETENV) $(CONF_ENV) $(MAKEPLUS_HOME)/check_lib.sh y
MP_REQUIRE_PROGS = $(SETENV) $(CONF_ENV) $(MAKEPLUS_HOME)/check_progs.sh y
MP_REQUIRE_PROG = $(MP_REQUIRE_PROGS)

MP_CHECK_GNU_TAR = $(SETENV) $(CONF_ENV) $(MAKEPLUS_HOME)/check_gnu_tar.sh
