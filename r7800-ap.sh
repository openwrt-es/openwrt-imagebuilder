#!/bin/bash

. lib/ib.sh

function main() {
	disable_signature_check

	release_tar_zst
	release_version "24.10-SNAPSHOT"

	firmware_packages "luci \
		-ath10k-firmware-qca9984-ct ath10k-firmware-qca9984 \
		-kmod-ath10k-ct kmod-ath10k"

	prepare_imagebuilder "ipq806x" "generic"
	build_firmware "ipq806x/generic" "netgear_r7800" "openwrt-*-netgear_r7800*.*"
}

main

exit 0
