#
# Cookbook Name:: wof_pip
# Recipe:: data
#
# Copyright 2016, Mapzen
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'wof_pip::_setup'
include_recipe 'wof_pip::_data_bundles' if node[:wof_pip][:data][:source] == :bundles
include_recipe 'wof_pip::_data_files'   if node[:wof_pip][:data][:source] == :files

file node[:wof_pip][:data][:initial_run_complete_file]

runit_service 'wof-pip-server' do
  action :nothing
end
