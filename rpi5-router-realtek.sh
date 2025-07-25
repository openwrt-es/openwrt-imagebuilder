#!/bin/bash

. lib/ib.sh

function main() {
	release_tar_zst
	release_version "24.10.2"

	firmware_packages "luci-ssl luci-app-uhttpd \
		luci-app-ddns wget-ssl drill \
		luci-proto-wireguard qrencode \
		luci-proto-ipv6 6in4 kmod-ipt-nat6 \
		luci-app-banip luci-app-sqm luci-app-upnp \
		luci-app-omcproxy luci-app-udpxy \
		bird3 btop ethtool htop mosquitto-client-nossl \
		mtr rpcapd \
		kmod-rp1-adc \
		kmod-r8168 kmod-r8125 kmod-r8126 kmod-r8127 \
		kmod-ipt-nathelper-rtsp \
		kmod-usb-net-asix-ax88179 kmod-usb-net-rtl8152 usbutils"
	firmware_files "files/rpi5-router"
	firmware_rootfs_partsize 256

	prepare_imagebuilder "bcm27xx" "bcm2712"
	build_firmware "bcm27xx/bcm2712" "rpi-5" "openwrt-*-rpi-5*.*"
}

main

exit 0
