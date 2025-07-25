#!/bin/bash

. lib/ib.sh

function main() {
	release_tar_zst
	release_version "24.10.2"

	firmware_packages "luci luci-app-ddns"

	prepare_imagebuilder "ath79" "generic"
	build_firmware "ath79/generic" "tplink_tl-wdr4300-v1" "openwrt-*-tplink_tl-wdr4300-*.*"
}

main

exit 0
