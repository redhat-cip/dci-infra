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
for arch in fedora-22-x86_64 fedora-23-x86_64 epel-7-x86_64; do

    if [[ "$arch" == "fedora-23-x86_64" ]]; then
        RPATH='fedora/23/x86_64'
    elif [[ "$arch" == "fedora-22-x86_64" ]]; then
        RPATH='fedora/22/x86_64'
    else
        RPATH='el/7/x86_64'
    fi

    mkdir -p current
    mock -r $arch rebuild --resultdir=current/${RPATH} ${HOME}/rpmbuild/SRPMS/${PROJ_NAME}*
done
