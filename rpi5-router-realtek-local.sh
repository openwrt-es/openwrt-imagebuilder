#!/bin/bash

. lib/ib.sh

function main() {
	release_tar_zst
	release_version "snapshots"
	firmware_packages "bird2 qrencode \
		irqbalance btop htop mosquitto-client-nossl \
		ethtool kmod-r8101 kmod-r8125 kmod-r8126 kmod-r8168 \
		kmod-usb-net-asix-ax88179 kmod-usb-net-rtl8152 usbutils \
		luci luci-app-sqm luci-app-upnp luci-proto-wireguard \
		luci-app-ddns wget-ssl drill"
	firmware_files "files/rpi5-router"

	prepare_imagebuilder "bcm27xx" "bcm2712"
	prepare_sdk "bcm27xx" "bcm2712" "gcc-13.3.0_musl"

	build_sdk_packages "bcm27xx/bcm2712" "rpi-5" "r8101 r8125 r8126 r8168"
	build_firmware "bcm27xx/bcm2712" "rpi-5" "openwrt-*-rpi-5*.*"
}

main

exit 0
