#!/bin/bash

. lib/ib.sh

function main() {
	release_tar_zst
	release_version "24.10.4"

	firmware_packages "luci-ssl luci-app-uhttpd \
		luci-app-ddns wget-ssl drill \
		luci-proto-wireguard qrencode \
		luci-app-sqm luci-app-upnp \
		bird3 ethtool htop mosquitto-client-nossl \
		kmod-hwmon-gpiofan kmod-hwmon-pwmfan \
		kmod-usb-net-asix-ax88179 kmod-usb-net-rtl8152 usbutils"
	firmware_files "files/rpi4-router"
	firmware_rootfs_partsize 256

	prepare_imagebuilder "bcm27xx" "bcm2711"
	build_firmware "bcm27xx/bcm2711" "rpi-4" "openwrt-*-rpi-4*.*"
}

main

exit 0
