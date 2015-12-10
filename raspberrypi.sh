#!/bin/bash

. lib/ib.sh

function build_cc() {
	release_version "chaos_calmer" "15.05"

	prepare_imagebuilder "brcm2708/bcm2708" "brcm2708-bcm2708"
	build_firmware "brcm2708" "RaspberryPi" "openwrt-*-bcm2708*.*"

	prepare_imagebuilder "brcm2708/bcm2709" "brcm2708-bcm2709"
	build_firmware "brcm2708" "RaspberryPi2" "openwrt-*-bcm2709*.*"
}

function build_trunk() {
	prepare_imagebuilder "brcm2708/generic" "brcm2708-bcm2708"
	build_firmware "brcm2708" "RaspberryPi" "openwrt-*-rpi*.*"

#	prepare_imagebuilder "brcm2708/bcm2709" "brcm2708-bcm2709"
#	build_firmware "brcm2708" "RaspberryPi_2" "openwrt-*-rpi-2*.*"
}

function main() {
	firmware_packages "luci luci-proto-ipv6"

	build_cc
#	build_trunk
}

main

exit 0
