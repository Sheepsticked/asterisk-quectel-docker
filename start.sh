#!/bin/bash
# Fix sound device permissions for quectel devices with UAC
chown asterisk:asterisk -R /dev/snd/

# Start Asterisk
exec /usr/sbin/asterisk -f -n -Uasterisk -Gdialout "$@"