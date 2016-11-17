#
# Cookbook Name:: apt_repo
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

cookbook_file '/etc/apt/sources.list' do
  source 'sources.list'
  owner 'root'
  group 'root'
  mode 00644
end

apt_package 'dpkg-dev' do
  action :install
  options "--force-yes"
end


apt_package 'apache2' do
  action :install
  options "--force-yes"
end

directory '/var/www/ubuntu1404' do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

cookbook_file '/etc/apache2/sites-enabled/rnb_repo.conf' do
  source '000-default.conf'
  owner 'root'
  group 'root'
  mode 00644
  action :create
  notifies :restart, 'service[apache2]'
end

file '/etc/apache2/sites-enabled/000-default' do
  action :delete
  notifies :restart, 'service[apache2]'
end

service 'apache2' do
  supports :status => true
  action [ :enable, :start ]
end

link '/var/www/ubuntu1404/debs' do
  to '/vagrant/www/ubuntu1404/debs'
end

cookbook_file '/root/scanpackages.sh' do
  source 'scanpackages.sh'
  owner 'root'
  group 'root'
  mode 00755
end
