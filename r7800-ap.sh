#!/bin/bash

. lib/ib.sh

function main() {
	release_tar_zst
	release_version "24.10.4"

	firmware_packages "luci-ssl luci-app-uhttpd \
		luci-app-banip \
		-ath10k-firmware-qca9984-ct ath10k-firmware-qca9984 \
		-kmod-ath10k-ct kmod-ath10k"

	prepare_imagebuilder "ipq806x" "generic"
	build_firmware "ipq806x/generic" "netgear_r7800" "openwrt-*-netgear_r7800*.*"
}

main

exit 0
