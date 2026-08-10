#!/system/bin/sh
# Copyright (C) 2026 meta-magic_mount-rs developers
# SPDX-License-Identifier: GPL-v3

MODDIR="${0%/*}"

BINARY="$MODDIR/meta-mm"

if [ ! -f "$BINARY" ]; then
  log "ERROR: Binary not found: $BINARY"
  exit 1
fi

if [ -f "/data/adb/magic_mount/mm.log" ]; then
  mv "/data/adb/magic_mount/mm.log" "/data/adb/magic_mount/mm.log.bak"
fi

echo "Start time: $(date '+%Y-%m-%d %H:%M:%S')" >"/data/adb/magic_mount/mm.log"
nohup $BINARY >>"/data/adb/magic_mount/mm.log" 2>&1

EXIT_CODE=$?
echo "Mount start: $(date '+%Y-%m-%d %H:%M:%S')" >"/data/adb/magic_mount/mm2.log"
if [ "$EXIT_CODE" = 0 ]; then
  /data/adb/ksud kernel notify-module-mounted
  echo "Mount completed successfully" >>"/data/adb/magic_mount/mm2.log"
else
  echo "Mount failed with exit code $EXIT_CODE" >>"/data/adb/magic_mount/mm2.log"
fi

exit $EXIT_CODE
