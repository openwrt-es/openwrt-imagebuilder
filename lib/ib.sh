#!/bin/bash

FW_RELEASE="snapshots"
FW_URL="https://downloads.openwrt.org"
FW_PACKAGES=""
CUSTOM_PACKAGES=""

FW_FILES=""
FW_KERNEL_PARTSIZE=""
FW_ROOTFS_PARTSIZE=""
CW_DIR="$(pwd)"
WS_DIR="${WS_DIR:-$CW_DIR}"
DL_DIR="$WS_DIR/dl"
BIN_DIR="$WS_DIR/bin"
ENV_DIR="$WS_DIR/env"
IB_DIR=""
SDK_DIR=""
SRC_PKG_DIR="$WS_DIR/packages"
SRC_KERNEL_PKG_DIR="$SRC_PKG_DIR/kernel"

RM_BIN=1
RM_IB=1
RM_IB_TAR=0
RM_IB_BIN=1
RM_SDK=1
RM_SDK_TAR=0
RM_SDK_BIN=1
SIGN_CHECK=1

TAR_EXT="tar.xz"
TAR_CMD="tar -Jxvf"

function disable_signature_check() {
	SIGN_CHECK=0
}

function release_tar_zst() {
	TAR_EXT="tar.zst"
	TAR_CMD="tar --zstd -xvf"
}

function release_version() {
	FW_RELEASE="$1"
}

function firmware_packages() {
	FW_PACKAGES="$1"
}

function custom_packages() {
	CUSTOM_PACKAGES="$1"
}

function firmware_files() {
	FW_FILES="$1"
}

function firmware_kernel_partsize() {
	FW_KERNEL_PARTSIZE="$1"
}

function firmware_rootfs_partsize() {
	FW_ROOTFS_PARTSIZE="$1"
}

function build_firmware() {
	local target="$1"
	local profile="$2"
	local firmwares="$3"
	local packages="$FW_PACKAGES $4"
	local files=$(echo "$FW_FILES $5" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
	local custom_packages=$(echo "$CUSTOM_PACKAGES $6" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

	cd $IB_DIR

	[ $RM_IB_BIN -eq 1 ] && rm -rf $IB_DIR/bin

	[ ! -z "$FW_KERNEL_PARTSIZE" ] && sed -i "s/CONFIG_TARGET_KERNEL_PARTSIZE=.*/CONFIG_TARGET_KERNEL_PARTSIZE=$FW_KERNEL_PARTSIZE/g" .config
	[ ! -z "$FW_ROOTFS_PARTSIZE" ] && sed -i "s/CONFIG_TARGET_ROOTFS_PARTSIZE=.*/CONFIG_TARGET_ROOTFS_PARTSIZE=$FW_ROOTFS_PARTSIZE/g" .config

	rm -rf $IB_DIR/files
	mkdir -p $IB_DIR/files
	for file_dir in $files; do
		case $file_dir in
			/*) cp -r $file_dir/* $IB_DIR/files/ ;;
			*) cp -r $WS_DIR/$file_dir/* $IB_DIR/files/ ;;
		esac
	done

	for cus_pkg in $custom_packages; do
		case $cus_pkg in
			/*) cp -r $cus_pkg $IB_DIR/packages/ ;;
			*) cp -r $WS_DIR/$cus_pkg $IB_DIR/packages/ ;;
		esac
	done

	make image PROFILE="$profile" PACKAGES="$packages" FILES="$IB_DIR/files"

	cd $IB_DIR/bin/targets/$target
	mkdir -p $BIN_DIR/$target
	cp $firmwares $BIN_DIR/$target/
}

function build_sdk_packages() {
	local target="$1"
	local profile="$2"
	local kernel_packages="$3"
	local bin_pkg_dir="$BIN_DIR/$target/packages"
	local ib_src_pkg_dir="$IB_DIR/packages"
	local sdk_bin_pkg_dir="$SDK_DIR/bin/targets/$target/packages"
	local sdk_src_pkg_dir="$SDK_DIR/package/kernel"

	cd $SDK_DIR

	[ $RM_SDK_BIN -eq 1 ] && rm -rf $SDK_DIR/bin

	for kernel_package in $kernel_packages; do
		cp -r $SRC_KERNEL_PKG_DIR/$kernel_package $sdk_src_pkg_dir
	done

	make defconfig V=s

	mkdir -p $bin_pkg_dir
	for kernel_package in $kernel_packages; do
		local pkg_ipk="$sdk_bin_pkg_dir/kmod-${kernel_package}_*.ipk"

		make package/$kernel_package/compile V=s

		cp $pkg_ipk $bin_pkg_dir
		cp $pkg_ipk $ib_src_pkg_dir
	done
}

function patch_imagebuilder() {
	local patch_file="$1"

	cd $IB_DIR
	patch -p1 -i $patch_file
}

function prepare_imagebuilder() {
	local target_url="$1/$2"
	local target_ib="$1-$2"
	local ib_name=""
	local openwrt_ib=""
	local openwrt_ib_tar=""
	local url=""
	local url_pfx=""

	cd $WS_DIR

	if [ $FW_RELEASE = "snapshots" ]; then
		url_pfx="${FW_URL}/${FW_RELEASE}"
	else
		url_pfx="${FW_URL}/releases/${FW_RELEASE}"
		ib_name="${FW_RELEASE}-"
	fi

	ib_name="${ib_name}${target_ib}"
	openwrt_ib="openwrt-imagebuilder-${ib_name}.Linux-x86_64"
	openwrt_ib_tar="${openwrt_ib}.${TAR_EXT}"
	url="${url_pfx}/targets/${target_url}/${openwrt_ib_tar}"
	openwrt_ib_tar="${DL_DIR}/${openwrt_ib_tar}"
	IB_DIR="${ENV_DIR}/$openwrt_ib"

	if [ $RM_IB_TAR -eq 1 ]; then
		rm -rf $openwrt_ib_tar
	fi
	if [ ! -f $openwrt_ib_tar ]; then
		$(download_file $openwrt_ib_tar $url)
	fi

	if [ $RM_IB -eq 1 ]; then
		rm -rf $IB_DIR
	fi
	if [ ! -d $IB_DIR ]; then
		$TAR_CMD $openwrt_ib_tar -C $ENV_DIR
	fi

	if [ $SIGN_CHECK -ne 1 ]; then
		cat $IB_DIR/repositories.conf
		sed -i 's/option check_signature/# option check_signature/' $IB_DIR/repositories.conf
	fi
}

function prepare_sdk() {
	local target_url="$1/$2"
	local target_ib="$1-$2"
	local target_gcc="$3"
	local sdk_name=""
	local openwrt_sdk=""
	local openwrt_sdk_tar=""
	local url=""
	local url_pfx=""

	cd $WS_DIR

	if [ $FW_RELEASE = "snapshots" ]; then
		url_pfx="${FW_URL}/${FW_RELEASE}"
	else
		url_pfx="${FW_URL}/releases/${FW_RELEASE}"
		sdk_name="${FW_RELEASE}-"
	fi

	sdk_name="${sdk_name}${target_ib}"
	openwrt_sdk="openwrt-sdk-${sdk_name}_${target_gcc}.Linux-x86_64"
	openwrt_sdk_tar="${openwrt_sdk}.${TAR_EXT}"
	url="${url_pfx}/targets/${target_url}/${openwrt_sdk_tar}"
	openwrt_sdk_tar="${DL_DIR}/${openwrt_sdk_tar}"
	SDK_DIR="${ENV_DIR}/$openwrt_sdk"

	if [ $RM_SDK_TAR -eq 1 ]; then
		rm -rf $openwrt_sdk_tar
	fi
	if [ ! -f $openwrt_sdk_tar ]; then
		$(download_file $openwrt_sdk_tar $url)
	fi

	if [ $RM_SDK -eq 1 ]; then
		rm -rf $SDK_DIR
	fi
	if [ ! -d $SDK_DIR ]; then
		$TAR_CMD $openwrt_sdk_tar -C $ENV_DIR
	fi
}

function download_file() {
	local file_name="$1"
	local file_url="$2"
	local file_force="${3:-0}"

	if [ ! -f "$file_name" ] || [ $file_force -eq 1 ]; then
		rm -f $file_name
		curl --insecure -o $file_name $file_url
	fi
}

function generate_checksums() {
	local target_dir="$BIN_DIR/$1"

	if [ -d $target_dir ]; then
		local tmp_sha256sums="/tmp/$(echo $1 | tr '/' '_')_sha256sums"

		cd $target_dir
		rm -f sha256sums
		sha256sum * > $tmp_sha256sums
		mv $tmp_sha256sums ./sha256sums
	fi
}

function setup_workspace() {
	[ $RM_BIN -eq 1 ] && rm -rf $BIN_DIR

	mkdir -p $WS_DIR
	mkdir -p $DL_DIR
	mkdir -p $ENV_DIR
	mkdir -p $BIN_DIR
}

setup_workspace
