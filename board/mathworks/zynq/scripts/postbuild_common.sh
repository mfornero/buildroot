#!/bin/bash
# format: <post-build-script.sh> <target dir> <board name>
# executed out of main buildroot source directory
# available environment variables
#	BUILDROOT_CONFIG: path to .config file
#	HOST_DIR, STAGING_DIR, TARGET_DIR
#	BINARIES_DIR: images dir
#	BASE_DIR: base output directory
TARGET_DIR=$1
BOARD_NAME=$2
BR_ROOT=$pwd
OUTPUT_DIR=$BASE_DIR
SCRIPT_DIR=$( cd "$( dirname "$0" )" && pwd )
BOARD_DIR=$( cd "$( dirname "${SCRIPT_DIR}" )" && pwd )

###################################
# Update inittab to not use getty
###################################
tempfile=$(mktemp)
sed 's|\(.*\)::respawn.*# GENERIC_SERIAL$|\1::respawn:-/bin/sh # GENERIC_SERIAL|' ${TARGET_DIR}/etc/inittab > $tempfile && \
	cat $tempfile > ${TARGET_DIR}/etc/inittab


