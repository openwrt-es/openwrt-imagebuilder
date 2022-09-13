#!/bin/bash

. lib/ib.sh

function main() {
	release_version "22.03.0"
	firmware_packages "bcm27xx-userland bird2 qrencode \
		irqbalance htop \
		kmod-hwmon-gpiofan kmod-hwmon-pwmfan \
		ethtool kmod-usb-net-rtl8152 usbutils \
		luci luci-app-ddns luci-app-sqm luci-app-upnp luci-app-wireguard \
		docker dockerd docker-compose luci-app-dockerman \
		kmod-usb-storage kmod-usb-storage-uas usbutils \
		block-mount libblkid \
		gdisk e2fsprogs kmod-fs-ext4 kmod-fs-f2fs f2fs-tools"
	firmware_files "files/rpi-router"
	firmware_rootfs_partsize "1024"

	prepare_imagebuilder "bcm27xx" "bcm2711"
	build_firmware "bcm27xx/bcm2711" "rpi-4" "openwrt-*-rpi-4*.*"
}

main

exit 0
