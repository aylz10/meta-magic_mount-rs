#!/system/bin/sh
# Copyright (C) 2026 meta-magic_mount-rs developers
# SPDX-License-Identifier: Apache-2.0

# meta-overlayfs Module Mount Handler
# This script is the entry point for dual-directory module mounting
[ ! -f "/dev/.esred" ] && exit 0
[ -f "/dev/.mounted" ] && exit 0
touch /dev/.mounted
MODDIR="${0%/*}"

ABI=$(getprop ro.product.cpu.abi)

if [ -z "$ABI" ]; then
  abort "! Failed to detect device architecture"
fi

BINARY="$MODDIR/meta-mm"

if [ ! -f "$BINARY" ]; then
  log "ERROR: Binary not found: $BINARY"
  exit 1
fi

#nohup $BINARY 2>&1
nohup $BINARY >"/data/adb/magic_mount/mm.log" 2>&1

EXIT_CODE=$?
echo "Mount start" >"/data/adb/magic_mount/mm2.log"
if [ "$EXIT_CODE" = 0 ]; then
  /data/adb/ksud kernel notify-module-mounted
  echo "Mount completed successfully" >>"/data/adb/magic_mount/mm2.log"
else
  echo "Mount failed with exit code $EXIT_CODE" >>"/data/adb/magic_mount/mm2.log"
fi

exit $EXIT_CODE
