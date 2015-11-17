#!/bin/bash
set -eux
PROJ_NAME=dci-sshpubkeys

# Create the proper filesystem hierarchy to proceed with srpm creatioon
#
rpmdev-setuptree
cp ${PROJ_NAME}.spec ${HOME}/rpmbuild/SPECS/
rpmbuild -bs ${HOME}/rpmbuild/SPECS/${PROJ_NAME}.spec

# Build the RPMs in a clean chroot environment with mock to detect missing
# BuildRequires lines.
mock rebuild --resultdir=./ ${HOME}/rpmbuild/SRPMS/${PROJ_NAME}*
