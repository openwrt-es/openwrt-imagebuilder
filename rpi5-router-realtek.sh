#!/bin/bash

. lib/ib.sh

function main() {
	release_tar_zst
	release_version "24.10-SNAPSHOT"

	firmware_packages "bird2 qrencode \
		irqbalance btop htop mosquitto-client-nossl \
		ethtool kmod-r8168 kmod-r8125 kmod-r8126 \
		kmod-usb-net-asix-ax88179 kmod-usb-net-rtl8152 usbutils \
		luci-ssl luci-app-uhttpd \
		luci-app-sqm luci-app-upnp luci-proto-wireguard \
		luci-app-ddns wget-ssl drill"
	firmware_files "files/rpi5-router"
	firmware_rootfs_partsize 256

	prepare_imagebuilder "bcm27xx" "bcm2712"
	build_firmware "bcm27xx/bcm2712" "rpi-5" "openwrt-*-rpi-5*.*"
}

main

exit 0
