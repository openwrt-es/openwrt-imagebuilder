#!/bin/bash

. lib/ib.sh

function main() {
	release_tar_zst
	release_version "24.10-SNAPSHOT"

	firmware_packages "luci-ssl luci-app-uhttpd \
		luci-proto-ipv6 \
		htop \
		kmod-mt7921u"

	prepare_imagebuilder "ath79" "generic"
	build_firmware "ath79/generic" "glinet_6416" "openwrt-*-glinet_6416-*.*"
}

main

exit 0
