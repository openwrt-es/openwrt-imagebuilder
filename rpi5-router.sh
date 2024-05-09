#!/bin/bash

. lib/ib.sh

function main() {
	release_version "snapshots"
	firmware_packages "bird2 qrencode \
		irqbalance htop mosquitto-client-nossl \
		ethtool kmod-r8169 kmod-usb-net-rtl8152 usbutils \
		luci luci-app-sqm luci-app-upnp luci-app-wireguard \
		luci-app-ddns wget-ssl drill"
	firmware_files "files/rpi5-router"

	prepare_imagebuilder "bcm27xx" "bcm2712"
	build_firmware "bcm27xx/bcm2712" "rpi-5" "openwrt-*-rpi-5*.*"
}

main

exit 0
