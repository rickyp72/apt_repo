#!/bin/bash
rsync -a /var/cache/apt/archives/ /var/www/ubuntu1404/debs
cd /vagrant/www/debs
dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz
