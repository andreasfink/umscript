#!/bin/bash

PROJECT_NAME="$1"
PKG_INSTALL_ROOT="$2"
PKG_INSTALL_RESOURCES="$3"
PKG_INSTALL_SCRIPTS="$4"
PKG_IDENTIFIER="com.smsrelay.${PROJECT_NAME}"

rm -rf "${PKG_INSTALL_ROOT}"
mkdir -p "${PKG_INSTALL_ROOT}" "${PKG_INSTALL_RESOURCES}" "${PKG_INSTALL_SCRIPTS}"

make DESTDIR="${PKG_INSTALL_ROOT}" install_for_pkg


SIGNING_KEY_INSTALLER="Developer ID Installer: SMSRelay AG"
SIGNING_KEY_LIB="Developer ID Application: SMSRelay AG (WMTUF4B7XX)"
PKGPREFIX=

VERSION=`cat VERSION`
LONGVER="$VERSION build  on `date`"
SHORTVER="$VERSION"
OUTPUT_FILE="${PROJECT_NAME}_${VERSION}.pkg"

pkgbuild --root "${PKG_INSTALL_ROOT}" \
	--install-location / \
	--scripts "${PKG_INSTALL_SCRIPTS}" 						\
	--sign "${SIGNING_KEY_INSTALLER}"  						\
	--version "${LONGVER}" \
	--identifier "${PKG_IDENTIFIER}" \
	"${OUTPUT_FILE}"
