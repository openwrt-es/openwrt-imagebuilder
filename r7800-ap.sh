#!/bin/bash

. lib/ib.sh

function main() {
	release_version "22.03.0"
	firmware_packages "ath10k-firmware-qca9984-ct-full-htt luci"

	prepare_imagebuilder "ipq806x" "generic"
	build_firmware "ipq806x/generic" "netgear_r7800" "openwrt-*-netgear_r7800*.*"
}

main

exit 0
