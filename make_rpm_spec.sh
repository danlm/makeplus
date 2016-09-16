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

# This RPM builder is not very smart at the moment. It should know more
# about libraries and building separate -devel and -doc packages at least.

set -e

manifest=$1; shift

cat <<EOF
Summary: $SUMMARY
Name: $PACKAGE
Version: $VERSION
Release: 1
Copyright: $COPYRIGHT
Group: $RPM_GROUP
Source: %{name}-%{version}.tar.gz
BuildRoot: /var/tmp/%{name}-%{version}-root
#BuildRequires: makeplus XXX uncomment before release!!!
EOF

if [ "x$RPM_BUILD_REQUIRES" != "x" ]; then
    echo "BuildRequires: $RPM_BUILD_REQUIRES"
fi

if [ "x$RPM_REQUIRES" != "x" ]; then
    echo "Requires: $RPM_REQUIRES"
fi

cat <<EOF
%description
$DESCRIPTION

%prep
%setup -q

%build
./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var
make+ all

%install
rm -rf \$RPM_BUILD_ROOT
mkdir -p \$RPM_BUILD_ROOT
make+ DESTDIR=\$RPM_BUILD_ROOT install

%post
# XXX Don't always run ldconfig, only if there is a library.
/sbin/ldconfig

%clean
rm -rf \$RPM_BUILD_ROOT

%files
%defattr(-,root,root)
EOF

sed 's|\(/man/.*\.[1-9ln]\)$|\1*|' < $manifest
