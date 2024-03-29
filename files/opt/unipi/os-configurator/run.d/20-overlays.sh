#!/bin/sh

#DT="bb030f id0074_slot12 ic006a_slot22 ic0073_slot32"

[ -z "$DT" ] && exit

# create bootcmd.d artefact

if [ -n "$HAS_DS2482" ] && [ "$HAS_DS2482"=="1" ]; then
    cd /etc/bootcmd.d/
    touch enable-1wmaster
fi

echo "setenv overlay ${DT}" >/etc/bootcmd.d/src/14-overlays.conf

# For Patron (unlike Neuron), the files are already copied in /boot/overlays

# append to words in udev list suffix .rules
dt_dtb_1=$(echo "${DT}" | sed 's/\>/.dtb/g')
if [ -n "$dt_dtb_1" ]; then
    ( cd /opt/unipi/os-configurator/overlays
      mkdir -p /boot/overlays
      cp $dt_dtb_1 /boot/overlays/
    )
fi
