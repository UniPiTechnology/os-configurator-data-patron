#!/bin/sh

[ -f /etc/bootcmd.d/Makefile ] || exit 0

if [ "$HAS_WATCHDOG1" = "1" ]; then
    make -C /etc/bootcmd.d use-watchdog1
else
    make -C /etc/bootcmd.d unuse-watchdog1
fi
