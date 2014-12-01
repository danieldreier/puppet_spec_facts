#!/bin/sh

# gather facter facts on boxes with puppet already installed
kernel=$(facter kernel)
arch=$(facter architecture)
release=$(facter operatingsystemrelease)
puppetversion=$(facter puppetversion)
osfamily=$(facter osfamily)
date=$(date +"%s")
mkdir -p "/vagrant/facts/${kernel}/${osfamily}"

puppet apply -e 'package {"curl": ensure => present}'
puppet config set stringify_facts true
fact_style="stringified"
filename="${kernel}-${osfamily}-${release}-${arch}-${puppetversion}-${fact_style}-${date}"

facter --json > "/vagrant/facts/${kernel}/${osfamily}/${filename}"
facter --json | curl -H "Content-Type: application/json" -d @- http://facts.whilefork.com

puppet config set stringify_facts false
fact_style="structured"
filename="${kernel}-${osfamily}-${release}-${arch}-${puppetversion}-${fact_style}-${date}"

facter --json > "/vagrant/facts/${kernel}/${osfamily}/${filename}"
facter --json | curl -H "Content-Type: application/json" -d @- http://facts.whilefork.com

shutdown -h now
