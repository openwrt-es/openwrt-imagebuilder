#!/bin/bash

. lib/ib.sh

function main() {
	release_tar_zst
	release_version "24.10.0-rc4"

	firmware_packages "luci-ssl luci-app-uhttpd \
		luci-app-ddns wget-ssl drill \
		luci-proto-wireguard qrencode \
		luci-app-sqm luci-app-upnp \
		bird2 ethtool htop mosquitto-client-nossl \
		kmod-r8169 \
		kmod-usb-net-asix-ax88179 kmod-usb-net-rtl8152 usbutils"
	firmware_files "files/rpi5-router"
	firmware_rootfs_partsize 256

	prepare_imagebuilder "bcm27xx" "bcm2712"
	build_firmware "bcm27xx/bcm2712" "rpi-5" "openwrt-*-rpi-5*.*"
}

main

exit 0
