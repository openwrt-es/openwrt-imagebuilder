#!/bin/bash

. lib/ib.sh

function main() {
	disable_signature_check

	release_tar_zst
	release_version "24.10-SNAPSHOT"

	firmware_packages "luci luci-app-ddns wget-ssl drill"

	prepare_imagebuilder "ath79" "generic"
	build_firmware "ath79/generic" "tplink_archer-c7-v2" "openwrt-*-tplink_archer-c7-v2*.*"
}

main

exit 0
