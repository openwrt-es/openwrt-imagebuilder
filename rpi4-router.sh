#!/bin/bash

. lib/ib.sh

function main() {
	release_version "23.05.2"
	firmware_packages "bcm27xx-userland bird2 qrencode \
		irqbalance htop mosquitto-client-nossl \
		kmod-hwmon-gpiofan kmod-hwmon-pwmfan \
		ethtool kmod-usb-net-rtl8152 usbutils \
		luci luci-app-sqm luci-app-upnp luci-app-wireguard \
		luci-app-ddns wget-ssl drill"
	firmware_files "files/rpi-router"

	prepare_imagebuilder "bcm27xx" "bcm2711"
	build_firmware "bcm27xx/bcm2711" "rpi-4" "openwrt-*-rpi-4*.*"
}

main

exit 0
