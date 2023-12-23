FROM timberio/vector:0.34.1-debian

# deb geoipupdate repo
COPY sources.list /etc/apt/sources.list

RUN  apt-get update && apt-get install -y cron gettext-base geoipupdate

COPY GeoIP.conf /etc/GeoIP.conf

COPY alpha2_to_alpha3_remap.csv /etc/vector/alpha2_to_alpha3_remap.csv
COPY vector.yaml /etc/vector/vector.yaml

COPY geoipupdate-cron /etc/cron.d/geoipupdate-cron
RUN chmod 0644 /etc/cron.d/geoipupdate-cron && crontab /etc/cron.d/geoipupdate-cron

COPY cron-entrypoint.sh /cron-entrypoint.sh
RUN chmod +x /cron-entrypoint.sh

# geoipupdate will download .mmdb in /usr/share/GeoIP
RUN mkdir /usr/share/GeoIP

ENTRYPOINT ["/cron-entrypoint.sh"]
