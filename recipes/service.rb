#
# Cookbook Name:: wof_pip
# Recipe:: service
#
# Copyright 2016, Mapzen
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'wof_pip::_setup'

# wof pip server
#
git "#{node[:wof_pip][:apps][:dir]}/wof-pip-server" do
  user        node[:wof_pip][:user][:name]
  repository  node[:wof_pip][:server][:repository]
  revision    node[:wof_pip][:server][:revision]
  notifies    :run,     'execute[compile wof server]',    :immediately
  notifies    :restart, 'runit_service[wof-pip-server]',  :delayed
  retries     2
  retry_delay 30
end

execute 'compile wof server' do
  action      :nothing
  user        node[:wof_pip][:user][:name]
  cwd         "#{node[:wof_pip][:apps][:dir]}/wof-pip-server"
  command     'make deps && make bin'
  retries     2
  retry_delay 10
  environment(
    'HOME'    => node[:wof_pip][:user][:home],
    'PATH'    => '/bin:/usr/bin:/sbin:/usr/bin:/usr/local/go/bin:/opt/go/bin',
    'GOBIN'   => '/opt/go/bin',
    'GOPATH'  => "#{node[:wof_pip][:apps][:dir]}/wof-pip-server"
  )
end

# service
#
include_recipe 'runit::default'

runit_service 'wof-pip-server' do
  action          :enable
  finish          false
  log             true
  default_logger  true
  sv_timeout      60
  retries         2
  retry_delay     10
  env(
    'PATH'    => '/bin:/usr/bin:/sbin:/usr/bin:/usr/local/go/bin:/opt/go/bin',
    'GOBIN'   => '/opt/go/bin',
    'GOPATH'  => "#{node[:wof_pip][:apps][:dir]}/wof-pip-server"
  )
end
