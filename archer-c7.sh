#!/bin/bash

. lib/ib.sh

function main() {
	release_tar_zst
	release_version "snapshots"

	firmware_packages "luci luci-app-ddns"

	prepare_imagebuilder "ath79" "generic"
	build_firmware "ath79/generic" "tplink_archer-c7-v2" "openwrt-*-tplink_archer-c7-v2*.*"
}

main

exit 0
