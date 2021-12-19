#!/bin/bash

. lib/ib.sh

function main() {
	release_version "snapshots"
	firmware_packages "bcm27xx-userland bird2 qrencode \
		kmod-hwmon-gpiofan kmod-hwmon-pwmfan kmod-usb-net-rtl8152 \
		luci luci-app-ddns luci-app-sqm luci-app-upnp luci-app-wireguard"
	firmware_files "files/rpi-router"

	prepare_imagebuilder "bcm27xx" "bcm2711"
	build_firmware "bcm27xx/bcm2711" "rpi-4" "openwrt-*-rpi-4*.*"
}

main

exit 0
