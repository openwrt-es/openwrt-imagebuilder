#!/bin/bash

FW_RELEASE="snapshots"
FW_VERSION="trunk"
FW_URL="https://downloads.openwrt.org"
FW_PACKAGES=""

FW_FILES=""
CW_DIR="$(pwd)"
WS_DIR="${WS_DIR:-$CW_DIR}"
DL_DIR="$WS_DIR/dl"
BIN_DIR="$WS_DIR/bin"
SDK_DIR="$WS_DIR/sdk"
IB_DIR=""

RM_BIN=1
RM_IB=0
RM_IB_TAR=0
RM_IB_BIN=1

function release_version() {
	FW_RELEASE="$1"
	FW_VERSION="$2"
}

function firmware_packages() {
	FW_PACKAGES="$1"
}

function firmware_files() {
	FW_FILES="$1"
}

function build_firmware() {
	local target="$1"
	local profile="$2"
	local firmwares="$3"
	local packages="$FW_PACKAGES $4"
	local files=$(echo "$FW_FILES $5" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

	cd $IB_DIR

	[ $RM_IB_BIN -eq 1 ] && rm -rf $IB_DIR/bin

	make image PROFILE="$profile" PACKAGES="$packages" FILES="$files"

	cd $IB_DIR/bin/$target
	mkdir -p $BIN_DIR/$target
	cp $firmwares $BIN_DIR/$target/
}

function prepare_imagebuilder() {
	local target_url="$1"
	local target_ib="$2"
	local ib_name=""
	local image_builder=""
	local image_builder_tar=""
	local url=""

	cd $WS_DIR

	if [ "$FW_VERSION" != "trunk" ]; then
		ib_name="${FW_VERSION}-"
	fi
	ib_name="${ib_name}${target_ib}"

	image_builder="OpenWrt-ImageBuilder-${ib_name}.Linux-x86_64"
	image_builder_tar="${image_builder}.tar.bz2"
	url="${FW_URL}/${FW_RELEASE}/${FW_VERSION}/${target_url}/${image_builder_tar}"
	image_builder_tar="${DL_DIR}/${image_builder_tar}"
	IB_DIR="${SDK_DIR}/$image_builder"

	if [ $RM_IB_TAR -eq 1 ]; then
		rm -rf $image_builder_tar
	fi
	if [ ! -f $image_builder_tar ]; then
		echo "Downloading $image_builder_tar from $url"
		curl --insecure -o $image_builder_tar $url
	fi

	if [ $RM_IB -eq 1 ]; then
		rm -rf $IB_DIR
	fi
	if [ ! -d $IB_DIR ]; then
		tar -jxvf $image_builder_tar -C $SDK_DIR
	fi
}

function generate_checksums() {
	local target_dir="$BIN_DIR/$1"

	if [ -d $target_dir ]; then
		local tmp_md5sums="/tmp/$1_md5sums"
		local tmp_sha256sums="/tmp/$1_sha256sums"

		cd $target_dir
		rm -f md5sums sha256sums
		md5sum * > $tmp_md5sums
		sha256sum * > $tmp_sha256sums
		mv $tmp_md5sums ./md5sums
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
