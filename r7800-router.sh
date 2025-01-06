#!/bin/bash

. lib/ib.sh

function main() {
	release_tar_zst
	release_version "24.10.0-rc5"

	firmware_packages "luci-ssl luci-app-uhttpd \
		luci-app-ddns wget-ssl drill \
		luci-proto-wireguard qrencode \
		luci-app-banip luci-app-sqm luci-app-upnp \
		bird2 ethtool htop mosquitto-client-nossl \
		-ath10k-firmware-qca9984-ct ath10k-firmware-qca9984 \
		-kmod-ath10k-ct kmod-ath10k"
	firmware_files "files/r7800-router"

	prepare_imagebuilder "ipq806x" "generic"
	build_firmware "ipq806x/generic" "netgear_r7800" "openwrt-*-netgear_r7800*.*"
}

main

exit 0
