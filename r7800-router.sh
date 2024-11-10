#!/bin/bash

. lib/ib.sh

function main() {
	release_tar_zst
	release_version "24.10-SNAPSHOT"

	firmware_packages "bird2 qrencode \
		luci luci-app-sqm luci-app-upnp luci-proto-wireguard \
		luci-app-ddns wget-ssl drill \
		-ath10k-firmware-qca9984-ct ath10k-firmware-qca9984 \
		-kmod-ath10k-ct kmod-ath10k"
	firmware_files "files/r7800-router"

	prepare_imagebuilder "ipq806x" "generic"
	build_firmware "ipq806x/generic" "netgear_r7800" "openwrt-*-netgear_r7800*.*"
}

main

exit 0
