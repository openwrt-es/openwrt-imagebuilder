#!/bin/bash

. lib/ib.sh

function main() {
	release_tar_zst
	release_version "25.12.0-rc3"

	firmware_packages "luci-ssl luci-app-uhttpd \
		luci-app-ddns ddns-scripts-ovh wget-ssl drill \
		luci-proto-wireguard qrencode \
		luci-proto-ipv6 6in4 kmod-ipt-nat6 \
		luci-app-banip luci-app-sqm luci-app-upnp \
		bird3 ethtool htop mosquitto-client-nossl mtr \
		-ath10k-firmware-qca9984-ct ath10k-firmware-qca9984 \
		-kmod-ath10k-ct kmod-ath10k \
		block-mount kmod-usb-storage usbutils \
		e2fsprogs kmod-fs-ext4"
	firmware_files "files/r7800-router"

	prepare_imagebuilder "ipq806x" "generic"
	build_firmware "ipq806x/generic" "netgear_r7800" "openwrt-*-netgear_r7800*.*"
}

main

exit 0
