#!/bin/bash

. lib/ib.sh

BCM63xx_BCMA="-kmod-b43 kmod-brcmsmac"
BCM63xx_SSB="-kmod-b43 -wpad-mini kmod-brcm-wl nas wlc"
BCM63xx_Kernels="vmlinux-a4001n.lzma.cfe \
	vmlinux-a4001n1.lzma.cfe \
	vmlinux-ar-5381u.lzma.cfe \
	vmlinux-ar-5387un.lzma.cfe \
	vmlinux-ct-5365.lzma.cfe \
	vmlinux-ct-6373.lzma.cfe \
	vmlinux-fast2604.lzma.cfe \
	vmlinux-hg520v.lzma.cfe \
	vmlinux-hg553.lzma.cfe \
	vmlinux-hg556a-a.lzma.cfe \
	vmlinux-hg556a-b.lzma.cfe \
	vmlinux-hg556a-c.lzma.cfe \
	vmlinux-hg655b.lzma.cfe \
	vmlinux-p870hw-51a-v2.lzma.cfe \
	vmlinux-vr-3025u.lzma.cfe \
	vmlinux-vr-3025un.lzma.cfe \
	vmlinux-wap-5813n.lzma.cfe"

function cc_brcm63xx_fixes() {
	# Align kernels to 4 bytes blocks
	cd $IB_DIR/build_dir/target-mips_mips32_uClibc-0.9.33.2/$1
	for file in $BCM63xx_Kernels; do
		dd if=$file of=$file.sync bs=4 conv=sync,noerror
		mv $file.sync $file
	done
}

function main() {
	release_version "chaos_calmer" "15.05.1"
	firmware_packages "luci luci-proto-ipv6"

	prepare_imagebuilder "brcm63xx/generic" "brcm63xx-generic"
	cc_brcm63xx_fixes "linux-brcm63xx_generic"
	build_firmware "brcm63xx" "A4001N" "openwrt-*-A4001N-*.*" "$BCM63xx_BCMA"
	build_firmware "brcm63xx" "A4001N1" "openwrt-*-A4001N1-*.*" "$BCM63xx_BCMA"
	build_firmware "brcm63xx" "AR5381u" "openwrt-*-AR-5381u*.*" "$BCM63xx_BCMA"
	build_firmware "brcm63xx" "AR5387un" "openwrt-*-AR-5387un*.*" "$BCM63xx_BCMA"
	build_firmware "brcm63xx" "CT5365" "openwrt-*-CT-5365*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx" "CT6373" "openwrt-*-CT-6373*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx" "FAST2604" "openwrt-*-F@ST2604*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx" "HG520v" "openwrt-*-HG520v*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx" "HG553" "openwrt-*-HG553*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx" "HG556a_AB" "openwrt-*-HG556a_A*.* openwrt-*-HG556a_B*.*"
	build_firmware "brcm63xx" "HG556a_C" "openwrt-*-HG556a_C*.*"
	build_firmware "brcm63xx" "HG655b" "openwrt-*-HG655b*.*"
	build_firmware "brcm63xx" "P870HW_51a_v2" "openwrt-*-P870HW-51a_v2*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx" "VR3025u" "openwrt-*-VR-3025u-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx" "VR3025un" "openwrt-*-VR-3025un-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx" "WAP5813n" "openwrt-*-WAP-5813n*.*" "$BCM63xx_SSB"

	prepare_imagebuilder "brcm63xx/smp" "brcm63xx-smp"
	cc_brcm63xx_fixes "linux-brcm63xx_smp"
	build_firmware "brcm63xx" "HG655b" "openwrt-*-HG655b*.*"
	build_firmware "brcm63xx" "P870HW_51a_v2" "openwrt-*-P870HW-51a_v2*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx" "VR3025u" "openwrt-*-VR-3025u-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx" "VR3025un" "openwrt-*-VR-3025un-*.*" "$BCM63xx_SSB"
	build_firmware "brcm63xx" "WAP5813n" "openwrt-*-WAP-5813n*.*" "$BCM63xx_SSB"

	prepare_imagebuilder "lantiq/xway" "lantiq-xway"
	build_firmware "lantiq" "ARV4518PWR01" "openwrt-*-ARV4518PWR01-*.*"
	build_firmware "lantiq" "ARV4518PWR01A" "openwrt-*-ARV4518PWR01A-*.*"
	build_firmware "lantiq" "ARV7510PW22" "openwrt-*-ARV7510PW22*.*"
	build_firmware "lantiq" "ARV7518PW" "openwrt-*-ARV7518PW*.*"

	prepare_imagebuilder "lantiq/xrx200" "lantiq-xrx200"
	build_firmware "lantiq" "ARV7519RW22" "openwrt-*-ARV7519RW22*squashfs.*"

	prepare_imagebuilder "ramips/rt305x" "ramips-rt305x"
	build_firmware "ramips" "ASL26555" "openwrt-*-asl26555*.*"
	build_firmware "ramips" "VOCORE" "openwrt-*-vocore*.*"

	generate_checksums "brcm63xx"
	generate_checksums "lantiq"
	generate_checksums "ramips"
}

main

exit 0
