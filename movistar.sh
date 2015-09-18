#!/bin/bash

. lib/ib.sh

BCM63xx_SSB="-kmod-b43 -wpad-mini kmod-brcm-wl nas wlc"

function cc_brcm63xx_fixes() {
	# Align kernels to 2 bytes blocks
	cd $IB_DIR/build_dir/target-mips_mips32_uClibc-0.9.33.2/$1
	for file in *.lzma.cfe; do
		dd if=$file of=$file.sync bs=2 conv=sync,noerror
		mv $file.sync $file
	done
}
function movistar_ftth() {
	local script_dir="$1/usr/sbin"
	local script="$script_dir/movistar"

	[ ! -d "$script_dir" ] && mkdir -p "$script_dir"
	download_file "$script" "https://raw.githubusercontent.com/openwrt-es/ftth-movistar/master/movistar.sh"
	chmod +x "$script"
}

function main() {
	movistar_ftth "$CW_DIR/files_movistar"

	release_version "chaos_calmer" "15.05"
	firmware_packages "kmod-bridge kmod-ipt-nathelper-rtsp bird4 mcproxy miniupnpd udpxy xupnpd luci luci-app-ddns luci-app-udpxy luci-app-upnp luci-proto-ipv6"
	firmware_files "$CW_DIR/files_movistar/"

	prepare_imagebuilder "ar71xx/generic" "ar71xx-generic"
	build_firmware "ar71xx" "TLWDR4300" "openwrt-*-tl-wdr3500*.* openwrt-*-tl-wdr3600*.* openwrt-*-tl-wdr43*.* openwrt-*-tl-mw4530r*.*"
	build_firmware "ar71xx" "TLWDR4900V2" "openwrt-*-tl-wdr4900*.*"
	build_firmware "ar71xx" "ARCHERC7" "openwrt-*-archer-c*.*"
	build_firmware "ar71xx" "TLWR1043" "openwrt-*-tl-wr1043nd*.*"

	prepare_imagebuilder "brcm63xx/generic" "brcm63xx-generic"
	cc_brcm63xx_fixes "linux-brcm63xx_generic"
	build_firmware "brcm63xx" "WAP5813n" "openwrt-*generic*-WAP-5813n*.*" "$BCM63xx_SSB"

	prepare_imagebuilder "brcm63xx/smp" "brcm63xx-smp"
	cc_brcm63xx_fixes "linux-brcm63xx_smp"
	build_firmware "brcm63xx" "WAP5813n" "openwrt-*smp*-WAP-5813n*.*" "$BCM63xx_SSB"

	prepare_imagebuilder "mvebu/generic" "mvebu"
	build_firmware "mvebu" "Caiman" "openwrt-*-linksys-caiman*.*"
	build_firmware "mvebu" "Cobra" "openwrt-*-linksys-cobra*.*"
	build_firmware "mvebu" "Mamba" "openwrt-*-linksys-mamba*.*"

	generate_checksums "ar71xx"
	generate_checksums "brcm63xx"
	generate_checksums "mvebu"
}

main

exit 0
