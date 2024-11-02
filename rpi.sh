#!/bin/bash

. lib/ib.sh

function main() {
	release_tar_zst
	release_version "snapshots"

	firmware_packages "luci"

	prepare_imagebuilder "bcm27xx" "bcm2708"
	build_firmware "bcm27xx/bcm2708" "rpi" "openwrt-*-rpi*.*"

	prepare_imagebuilder "bcm27xx" "bcm2709"
	build_firmware "bcm27xx/bcm2709" "rpi-2" "openwrt-*-rpi-2*.*"

	prepare_imagebuilder "bcm27xx" "bcm2710"
	build_firmware "bcm27xx/bcm2710" "rpi-3" "openwrt-*-rpi-3*.*"

	prepare_imagebuilder "bcm27xx" "bcm2711"
	build_firmware "bcm27xx/bcm2711" "rpi-4" "openwrt-*-rpi-4*.*"

	prepare_imagebuilder "bcm27xx" "bcm2712"
	build_firmware "bcm27xx/bcm2712" "rpi-5" "openwrt-*-rpi-5*.*"
}

main

exit 0
