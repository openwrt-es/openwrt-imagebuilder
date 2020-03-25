#!/bin/bash

. lib/ib.sh

function main() {
	release_version "snapshots"
	firmware_packages "luci luci-proto-ipv6"

	prepare_imagebuilder "ar71xx" "generic"
	build_firmware "ar71xx/generic" "archer-c7-v1" "openwrt-*-archer-c7-v1*.*"
	build_firmware "ar71xx/generic" "archer-c7-v2" "openwrt-*-archer-c7-v2*.*"
}

main

exit 0
