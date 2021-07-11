#!/bin/bash

. lib/ib.sh

function main() {
	release_version "21.02-SNAPSHOT"
	firmware_packages "luci luci-app-ddns"

	prepare_imagebuilder "ath79" "generic"
	build_firmware "ath79/generic" "tplink_tl-wdr4300-v1" "openwrt-*-tplink_tl-wdr4300-*.*"
}

main

exit 0
