#!/bin/sh

envsubst '${GEOIP_ACCOUNT_ID} ${GEOIP_LICENSE_KEY}' < /etc/GeoIP.conf > /etc/GeoIP.conf.tmp && mv /etc/GeoIP.conf.tmp /etc/GeoIP.conf
echo 'envsubst done'

geoipupdate
echo 'geoipupdate done'

vector & cron -f
