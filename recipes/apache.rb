#
# Cookbook Name:: wof_pip
# Recipe:: apache
#
# Copyright 2016, Mapzen
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apache2::default'

%w(proxy expires proxy_http proxy_connect).each do |m|
  apache_module m
end

directory node[:wof_pip][:apache][:docroot] do
  action  :create
  owner   'root'
  group   'root'
  mode    0755
end

%w(default 000-default).each do |site|
  apache_site site do
    enable false
  end
end

web_app 'wof-pip-proxy' do
  template          'wof-pip-proxy.conf.erb'
  docroot           node[:wof_pip][:apache][:docroot]
  port              node[:wof_pip][:apache][:port]
  proxy_port        node[:wof_pip][:server][:port]
  server_name       node[:wof_pip][:apache][:server_name]
  max               node[:wof_pip][:apache][:max]
  ttl               node[:wof_pip][:apache][:ttl]
  acquire           node[:wof_pip][:apache][:acquire]
  retrytimeout      node[:wof_pip][:apache][:retrytimeout]
  connectiontimeout node[:wof_pip][:apache][:connectiontimeout]
  requesttimeout    node[:wof_pip][:apache][:requesttimeout]
  base_uri          node[:wof_pip][:apache][:base_uri]
  max_age           node[:wof_pip][:apache][:max_age]
end

apache_site 'wof-pip-proxy' do
  action :enable
end
