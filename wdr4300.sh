#!/bin/bash

. lib/ib.sh

function main() {
	release_version "chaos_calmer" "15.05-rc3"
	firmware_packages "luci luci-app-wol luci-proto-ipv6"

	prepare_imagebuilder "ar71xx/generic" "ar71xx-generic"
	build_firmware "ar71xx" "TLWDR4300" "openwrt-*-tl-wdr4300*.*"
}

main

exit 0
