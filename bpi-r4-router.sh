#!/bin/bash

. lib/ib.sh

function main() {
	release_tar_zst
	release_version "25.12.0-rc5"

	firmware_packages "luci-ssl luci-app-uhttpd \
		luci-app-ddns wget-ssl drill \
		luci-proto-wireguard qrencode \
		luci-proto-ipv6 kmod-ipt-nat6 \
		luci-app-banip luci-app-sqm luci-app-upnp \
		luci-app-omcproxy luci-app-udpxy \
		bird3 btop ethtool htop mosquitto-client-nossl \
		mtr rpcapd tcpdump usbutils \
		kmod-ipt-nathelper-rtsp \
		-kmod-mt7996-firmware -kmod-mt7996-233-firmware \
		kmod-mt7921-firmware kmod-mt7921e"

	prepare_imagebuilder "mediatek" "filogic"
	build_firmware "mediatek/filogic" "bananapi_bpi-r4" "openwrt-*-bananapi_bpi-r4-*.*"
}

main

exit 0
