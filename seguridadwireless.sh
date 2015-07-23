#!/bin/bash

. lib/ib.sh

BCM63xx_BCMA="-kmod-b43 kmod-brcmsmac"

function main() {
	release_version "chaos_calmer" "15.05-rc3"
	firmware_packages "luci luci-proto-ipv6"

	prepare_imagebuilder "brcm63xx/generic" "brcm63xx-generic"
	build_firmware "brcm63xx" "A4001N" "openwrt-*-AR-4001N-*.*" "$BCM63xx_BCMA"
	build_firmware "brcm63xx" "A4001N1" "openwrt-*-AR-A4001N1-*.*" "$BCM63xx_BCMA"
	build_firmware "brcm63xx" "AR5381u" "openwrt-*-AR-5381u*.*" "$BCM63xx_BCMA"
	build_firmware "brcm63xx" "AR5387un" "openwrt-*-AR-5387un*.*" "$BCM63xx_BCMA"
	build_firmware "brcm63xx" "CT5365" "openwrt-*-CT-5365*.*"
	build_firmware "brcm63xx" "CT6373" "openwrt-*-CT-6373*.*"
	build_firmware "brcm63xx" "FAST2604" "openwrt-*-F@ST2604*.*"
	build_firmware "brcm63xx" "HG520v" "openwrt-*-HG520v*.*"
	build_firmware "brcm63xx" "HG553" "openwrt-*-HG553*.*"
	build_firmware "brcm63xx" "HG556a_AB" "openwrt-*-HG556a_A*.* openwrt-*-HG556a_B*.*"
	build_firmware "brcm63xx" "HG556a_C" "openwrt-*-HG556a_C*.*"
	build_firmware "brcm63xx" "HG655b" "openwrt-*-HG655b*.*"
	build_firmware "brcm63xx" "P870HW_51a_v2" "openwrt-*-P870HW-51a_v2*.*"
	build_firmware "brcm63xx" "VR3025u" "openwrt-*-VR-3025u-*.*"
	build_firmware "brcm63xx" "VR3025un" "openwrt-*-VR-3025un-*.*"
	build_firmware "brcm63xx" "WAP5813n" "openwrt-*-WAP-5813n*.*"

	prepare_imagebuilder "brcm63xx/smp" "brcm63xx-smp"
	build_firmware "brcm63xx" "HG655b" "openwrt-*-HG655b*.*"
	build_firmware "brcm63xx" "P870HW_51a_v2" "openwrt-*-P870HW-51a_v2*.*"
	build_firmware "brcm63xx" "VR3025u" "openwrt-*-VR-3025u-*.*"
	build_firmware "brcm63xx" "VR3025un" "openwrt-*-VR-3025un-*.*"
	build_firmware "brcm63xx" "WAP5813n" "openwrt-*-WAP-5813n*.*"

	prepare_imagebuilder "lantiq/xway" "lantiq-xway"
	build_firmware "lantiq" "ARV4518PWR01" "openwrt-*-ARV4518PWR01-*.*"
	build_firmware "lantiq" "ARV4518PWR01A" "openwrt-*-ARV4518PWR01A-*.*"
	build_firmware "lantiq" "ARV7510PW22" "openwrt-*-ARV7510PW22*.*"
	build_firmware "lantiq" "ARV7518PW" "openwrt-*-ARV7518PW*.*"

	prepare_imagebuilder "lantiq/xrx200" "lantiq-xrx200"
	build_firmware "lantiq" "ARV7519RW22" "openwrt-*-ARV7519RW22*.*"

	prepare_imagebuilder "ramips/rt305x" "ramips-rt305x"
	build_firmware "ramips" "ASL26555" "openwrt-*-asl26555*.*"
	build_firmware "ramips" "VOCORE" "openwrt-*-vocore*.*"

	generate_checksums "brcm63xx"
	generate_checksums "lantiq"
	generate_checksums "ramips"
}

main

exit 0
