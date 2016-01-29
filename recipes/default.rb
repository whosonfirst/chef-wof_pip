#
# Cookbook Name:: wof_pip
# Recipe:: setup
#
# Copyright 2016, Mapzen
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'wof_pip::service'
include_recipe 'wof_pip::apache' if node[:wof_pip][:apache][:include] == true
include_recipe 'wof_pip::data'
