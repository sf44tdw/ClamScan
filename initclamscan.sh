#!/bin/bash
cp -a /etc/freshclam.conf{,.org}
sed -i '/^Example/s/^/#/' /etc/freshclam.conf
