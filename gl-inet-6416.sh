#!/bin/bash

. lib/ib.sh

function main() {
	release_tar_zst
	release_version "snapshots"

	firmware_packages "luci"

	prepare_imagebuilder "ath79" "generic"
	build_firmware "ath79/generic" "glinet_6416" "openwrt-*-glinet_6416-*.*"
}

main

exit 0
