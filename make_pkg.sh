#!/bin/bash

PROJECT_NAME="$1"
PKG_INSTALL_ROOT=$2
PKG_INSTALL_RESOURCES=$3
PKG_INSTALL_SCRIPTS=$4
PKG_IDENTIFIER="com.smsrelay.${PROJECT_NAME}"
rm -rf "${PKG_INSTALL_ROOT}"
mkdir -p "${PKG_INSTALL_ROOT}" "${PKG_INSTALL_SCRIPTS}"

xcodebuild DSTROOT="${PKG_INSTALL_ROOT}" install

SIGNING_KEY_INSTALLER="Developer ID Installer: SMSRelay AG"
VERSION=`cat VERSION`
BUILDDATE=`date +%Y%m%d%H%M`
OUTPUT_FILE="${PROJECT_NAME}_${VERSION}_${BUILDDATE}.pkg"

pkgbuild --root "${PKG_INSTALL_ROOT}" \
    --install-location / \
    --scripts "${PKG_INSTALL_SCRIPTS}" 						\
    --sign "${SIGNING_KEY_INSTALLER}"  						\
    --version "${VERSION}" \
    --identifier "${PKG_IDENTIFIER}" \
    "${OUTPUT_FILE}"
