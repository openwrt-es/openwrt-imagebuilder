#!/bin/bash

. lib/ib.sh

function main() {
	release_version "21.02-SNAPSHOT"
	firmware_packages "luci luci-app-ddns"

	prepare_imagebuilder "ar71xx" "generic"
	build_firmware "ar71xx/generic" "tl-wdr4300-v1" "openwrt-*-tl-wdr4300*.*"
}

main

exit 0
