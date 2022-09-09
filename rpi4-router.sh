#!/bin/bash

. lib/ib.sh

function main() {
	release_version "22.03.0"
	custom_packages "packages/rpi4/22.03.0/kmod-usb-net-rtl8152-vendor_5.10.138+2.16.3-bcm27xx-1_aarch64_cortex-a72.ipk"
	firmware_packages "bcm27xx-userland bird2 qrencode \
		irqbalance htop \
		kmod-hwmon-gpiofan kmod-hwmon-pwmfan \
		ethtool kmod-usb-net-rtl8152-vendor usbutils \
		luci luci-app-ddns luci-app-sqm luci-app-upnp luci-app-wireguard"
	firmware_files "files/rpi-router"

	prepare_imagebuilder "bcm27xx" "bcm2711"
	build_firmware "bcm27xx/bcm2711" "rpi-4" "openwrt-*-rpi-4*.*"
}

main

exit 0
