#!/bin/bash

FW_RELEASE="snapshots"
FW_URL="https://downloads.openwrt.org"
FW_PACKAGES=""

FW_FILES=""
FW_KERNEL_PARTSIZE=""
FW_ROOTFS_PARTSIZE=""
CW_DIR="$(pwd)"
WS_DIR="${WS_DIR:-$CW_DIR}"
DL_DIR="$WS_DIR/dl"
BIN_DIR="$WS_DIR/bin"
SDK_DIR="$WS_DIR/sdk"
IB_DIR=""

RM_BIN=1
RM_IB=1
RM_IB_TAR=0
RM_IB_BIN=1

TAR_EXT="tar.xz"
TAR_CMD="tar -Jxvf"

function release_version() {
	FW_RELEASE="$1"
}

function firmware_packages() {
	FW_PACKAGES="$1"
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

	cd $IB_DIR

	[ $RM_IB_BIN -eq 1 ] && rm -rf $IB_DIR/bin

	[ ! -z "$FW_KERNEL_PARTSIZE" ] && sed -i "s/CONFIG_TARGET_KERNEL_PARTSIZE=.*/CONFIG_TARGET_KERNEL_PARTSIZE=$FW_KERNEL_PARTSIZE/g" .config
	[ ! -z "$FW_ROOTFS_PARTSIZE" ] && sed -i "s/CONFIG_TARGET_ROOTFS_PARTSIZE=.*/CONFIG_TARGET_ROOTFS_PARTSIZE=$FW_ROOTFS_PARTSIZE/g" .config

	make image PROFILE="$profile" PACKAGES="$packages" FILES="$files"

	cd $IB_DIR/bin/targets/$target
	mkdir -p $BIN_DIR/$target
	cp $firmwares $BIN_DIR/$target/
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
	local image_builder=""
	local image_builder_tar=""
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
	image_builder="openwrt-imagebuilder-${ib_name}.Linux-x86_64"
	image_builder_tar="${image_builder}.${TAR_EXT}"
	url="${url_pfx}/targets/${target_url}/${image_builder_tar}"
	image_builder_tar="${DL_DIR}/${image_builder_tar}"
	IB_DIR="${SDK_DIR}/$image_builder"

	if [ $RM_IB_TAR -eq 1 ]; then
		rm -rf $image_builder_tar
	fi
	if [ ! -f $image_builder_tar ]; then
		$(download_file $image_builder_tar $url)
	fi

	if [ $RM_IB -eq 1 ]; then
		rm -rf $IB_DIR
	fi
	if [ ! -d $IB_DIR ]; then
		$TAR_CMD $image_builder_tar -C $SDK_DIR
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
	mkdir -p $SDK_DIR
	mkdir -p $BIN_DIR
}

setup_workspace
