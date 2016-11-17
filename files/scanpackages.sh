#!/bin/bash
# rsync -a /var/cache/apt/archives/ /vagrant/www/ubuntu1404/debs
cd /vagrant/www/ubuntu1404/debs
dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz
