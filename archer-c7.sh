#!/bin/bash

. lib/ib.sh

function main() {
	release_tar_zst
	release_version "25.12.0-rc2"

	firmware_packages "luci-ssl luci-app-uhttpd \
		luci-app-ddns ddns-scripts-ovh wget-ssl drill \
		luci-app-banip \
		luci-proto-wireguard qrencode \
		luci-proto-ipv6 6in4 kmod-ipt-nat6 \
		htop"

	prepare_imagebuilder "ath79" "generic"
	build_firmware "ath79/generic" "tplink_archer-c7-v2" "openwrt-*-tplink_archer-c7-v2*.*"
}

main

exit 0
