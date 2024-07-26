#!/bin/bash

. lib/ib.sh

function main() {
	release_version "23.05.4"
	firmware_packages "ath10k-firmware-qca9984-ct-full-htt bird2 qrencode \
		luci luci-app-sqm luci-app-upnp luci-app-wireguard \
		luci-app-ddns wget-ssl drill"
	firmware_files "files/r7800-router"

	prepare_imagebuilder "ipq806x" "generic"
	build_firmware "ipq806x/generic" "netgear_r7800" "openwrt-*-netgear_r7800*.*"
}

main

exit 0
