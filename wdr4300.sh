#!/bin/bash

. lib/ib.sh

function main() {
	release_version "snapshots"
	firmware_packages "luci luci-proto-ipv6"

	prepare_imagebuilder "ar71xx" "generic"
	build_firmware "ar71xx/generic" "tl-wdr4300-v1" "lede-*-tl-wdr4300*.*"
}

main

exit 0
