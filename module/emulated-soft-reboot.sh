#!/system/bin/sh
# Copyright (C) 2026 meta-magic_mount-rs developers
# SPDX-License-Identifier: GPL-v3


MODDIR="${0%/*}"

BINARY="$MODDIR/meta-mm"

if [ ! -f "$BINARY" ]; then
  log "ERROR: Binary not found: $BINARY"
  exit 1
fi

if [ -f "/data/adb/magic_mount/mm1.log" ]; then
  mv "/data/adb/magic_mount/mm1.log" "/data/adb/magic_mount/mm1.log.bak"
fi

echo "emulated-soft-reboot time: $(date '+%Y-%m-%d %H:%M:%S')" >"/data/adb/magic_mount/mm1.log"
nohup $BINARY emulated-soft-reboot >>"/data/adb/magic_mount/mm1.log" 2>&1

EXIT_CODE=$?

exit $EXIT_CODE
