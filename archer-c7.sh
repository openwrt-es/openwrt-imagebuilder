#!/bin/bash

. lib/ib.sh

function main() {
	release_version "23.05.2"
	firmware_packages "luci"

	prepare_imagebuilder "ath79" "generic"
	build_firmware "ath79/generic" "tplink_archer-c7-v2" "openwrt-*-tplink_archer-c7-v2*.*"
}

main

exit 0
