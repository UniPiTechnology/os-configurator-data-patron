#!/bin/sh

#DT="bb030f id0074_slot12 ic006a_slot22 ic0073_slot32"

[ -z "$DT" ] && exit

# create bootcmd.d artefact

#if [ -n "$HAS_DS2482" ] && [ "$HAS_DS2482"=="1" ]; then
#    cd /etc/bootcmd.d/
#    touch enable-1wmaster
#fi

echo "setenv overlay ${DT}" >/etc/bootcmd.d/src/14-overlays.conf

