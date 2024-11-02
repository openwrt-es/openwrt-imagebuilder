#!/bin/bash

. lib/ib.sh

BCM63xx_BCMA="-kmod-b43 kmod-brcmsmac"
BCM63xx_SSB="-kmod-b43 -wpad-mini kmod-brcm-wl nas wlc"

function main() {
	release_tar_zst
	release_version "snapshots"

	firmware_packages "luci luci-proto-ipv6"

	prepare_imagebuilder "ar71xx" "generic"
	build_firmware "ar71xx/generic" "archer-c7-v1" "openwrt-*-archer-c7-v1*.*"
	build_firmware "ar71xx/generic" "archer-c7-v2" "openwrt-*-archer-c7-v2*.*"
	build_firmware "ar71xx/generic" "tl-wdr4300-v1" "openwrt-*-tl-wdr4300*.*"

	prepare_imagebuilder "brcm63xx" "generic"
	build_firmware "brcm63xx/generic" "A4001N" "openwrt-*-A4001N-*.*" "$BCM63xx_BCMA"
	build_firmware "brcm63xx/generic" "A4001N1" "openwrt-*-A4001N1-*.*" "$BCM63xx_BCMA"
	build_firmware "brcm63xx/generic" "AR5381u" "openwrt-*-AR5381u-*.*" "$BCM63xx_BCMA"
	build_firmware "brcm63xx/generic" "AR5387un" "openwrt-*-AR5387un-*.*" "$BCM63xx_BCMA"
	build_firmware "brcm63xx/generic" "CT-6373" "openwrt-*-CT-6373-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/generic" "HG520v" "openwrt-*-HG520v-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/generic" "HG553" "openwrt-*-HG553-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/generic" "HG556a-A" "openwrt-*-HG556a-A-*.*"
	build_firmware "brcm63xx/generic" "HG556a-B" "openwrt-*-HG556a-B-*.*"
	build_firmware "brcm63xx/generic" "HG556a-C" "openwrt-*-HG556a-C-*.*"
	build_firmware "brcm63xx/generic" "HG622" "openwrt-*-HG622-*.*"
	build_firmware "brcm63xx/generic" "HG655b" "openwrt-*-HG655b-*.*"
	build_firmware "brcm63xx/generic" "P870HW-51a_v2" "openwrt-*-P870HW-51a_v2-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/generic" "VR-3025u" "openwrt-*-VR-3025u-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/generic" "VR-3025un" "openwrt-*-VR-3025un-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/generic" "WAP-5813n" "openwrt-*-WAP-5813n-*.*" "$BCM63xx_SSB"

	prepare_imagebuilder "brcm63xx" "smp"
	build_firmware "brcm63xx/smp" "HG622" "openwrt-*-HG622-*.*"
	build_firmware "brcm63xx/smp" "HG655b" "openwrt-*-HG655b-*.*"
	build_firmware "brcm63xx/smp" "P870HW-51a_v2" "openwrt-*-P870HW-51a_v2-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/smp" "VR-3025u" "openwrt-*-VR-3025u-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/smp" "VR-3025un" "openwrt-*-VR-3025un-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/smp" "WAP-5813n" "openwrt-*-WAP-5813n-*.*" "$BCM63xx_SSB"

	prepare_imagebuilder "lantiq" "xway"
	build_firmware "lantiq/xway" "ARV4518PWR01" "openwrt-*-ARV4518PWR01-*.*"
	build_firmware "lantiq/xway" "ARV4518PWR01A" "openwrt-*-ARV4518PWR01A-*.*"
	build_firmware "lantiq/xway" "ARV7510PW22" "openwrt-*-ARV7510PW22*.*"
	build_firmware "lantiq/xway" "ARV7518PW" "openwrt-*-ARV7518PW*.*"

	prepare_imagebuilder "lantiq" "xrx200"
	build_firmware "lantiq/xrx200" "ARV7519RW22" "openwrt-*-ARV7519RW22*.*"

	prepare_imagebuilder "ramips" "rt305x"
	build_firmware "ramips/rt305x" "asl26555-8M" "openwrt-*-asl26555-8M*.*"
	build_firmware "ramips/rt305x" "asl26555-16M" "openwrt-*-asl26555-16M*.*"
	build_firmware "ramips/rt305x" "vocore-8M" "openwrt-*-vocore-8M*.*"
	build_firmware "ramips/rt305x" "vocore-16M" "openwrt-*-vocore-16M*.*"

	generate_checksums "ar71xx/generic"
	generate_checksums "brcm63xx/generic"
	generate_checksums "brcm63xx/smp"
	generate_checksums "lantiq/xrx200"
	generate_checksums "lantiq/xway"
	generate_checksums "ramips/rt305x"
}

main

exit 0
