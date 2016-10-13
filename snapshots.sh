#!/bin/bash

. lib/ib.sh

BCM63xx_BCMA="-kmod-b43 kmod-brcmsmac"
BCM63xx_SSB="-kmod-b43 -wpad-mini kmod-brcm-wl nas wlc"

function main() {
	release_version "snapshots"
	firmware_packages "luci luci-proto-ipv6"

	prepare_imagebuilder "ar71xx" "generic"
	build_firmware "ar71xx/generic" "archer-c7-v1" "lede-*-archer-c7-v1*.*"
	build_firmware "ar71xx/generic" "archer-c7-v2" "lede-*-archer-c7-v2*.*"
	build_firmware "ar71xx/generic" "tl-wdr4300-v1" "lede-*-tl-wdr4300*.*"

	prepare_imagebuilder "brcm63xx" "generic"
	build_firmware "brcm63xx/generic" "A4001N" "lede-*-A4001N-*.*" "$BCM63xx_BCMA"
	build_firmware "brcm63xx/generic" "A4001N1" "lede-*-A4001N1-*.*" "$BCM63xx_BCMA"
	build_firmware "brcm63xx/generic" "AR5381u" "lede-*-AR5381u-*.*" "$BCM63xx_BCMA"
	build_firmware "brcm63xx/generic" "AR5387un" "lede-*-AR5387un-*.*" "$BCM63xx_BCMA"
	build_firmware "brcm63xx/generic" "CT-6373" "lede-*-CT-6373-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/generic" "HG520v" "lede-*-HG520v-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/generic" "HG553" "lede-*-HG553-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/generic" "HG556a-A" "lede-*-HG556a-A-*.*"
	build_firmware "brcm63xx/generic" "HG556a-B" "lede-*-HG556a-B-*.*"
	build_firmware "brcm63xx/generic" "HG556a-C" "lede-*-HG556a-C-*.*"
	build_firmware "brcm63xx/generic" "HG622" "lede-*-HG622-*.*"
	build_firmware "brcm63xx/generic" "HG655b" "lede-*-HG655b-*.*"
	build_firmware "brcm63xx/generic" "P870HW-51a_v2" "lede-*-P870HW-51a_v2-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/generic" "VR-3025u" "lede-*-VR-3025u-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/generic" "VR-3025un" "lede-*-VR-3025un-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/generic" "WAP-5813n" "lede-*-WAP-5813n-*.*" "$BCM63xx_SSB"

	prepare_imagebuilder "brcm63xx" "smp"
	build_firmware "brcm63xx/smp" "HG622" "lede-*-HG622-*.*"
	build_firmware "brcm63xx/smp" "HG655b" "lede-*-HG655b-*.*"
	build_firmware "brcm63xx/smp" "P870HW-51a_v2" "lede-*-P870HW-51a_v2-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/smp" "VR-3025u" "lede-*-VR-3025u-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/smp" "VR-3025un" "lede-*-VR-3025un-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx/smp" "WAP-5813n" "lede-*-WAP-5813n-*.*" "$BCM63xx_SSB"

	prepare_imagebuilder "lantiq" "xway"
	build_firmware "lantiq/xway" "ARV4518PWR01" "lede-*-ARV4518PWR01-*.*"
	build_firmware "lantiq/xway" "ARV4518PWR01A" "lede-*-ARV4518PWR01A-*.*"
	build_firmware "lantiq/xway" "ARV7510PW22" "lede-*-ARV7510PW22*.*"
	build_firmware "lantiq/xway" "ARV7518PW" "lede-*-ARV7518PW*.*"

	prepare_imagebuilder "lantiq" "xrx200"
	build_firmware "lantiq/xrx200" "ARV7519RW22" "lede-*-ARV7519RW22*.*"

	prepare_imagebuilder "ramips" "rt305x"
	build_firmware "ramips/rt305x" "asl26555-8M" "lede-*-asl26555-8M*.*"
	build_firmware "ramips/rt305x" "asl26555-16M" "lede-*-asl26555-16M*.*"
	build_firmware "ramips/rt305x" "vocore-8M" "lede-*-vocore-8M*.*"
	build_firmware "ramips/rt305x" "vocore-16M" "lede-*-vocore-16M*.*"

	generate_checksums "ar71xx/generic"
	generate_checksums "brcm63xx/generic"
	generate_checksums "brcm63xx/smp"
	generate_checksums "lantiq/xrx200"
	generate_checksums "lantiq/xway"
	generate_checksums "ramips/rt305x"
}

main

exit 0
