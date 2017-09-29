#
# Cookbook Name:: wof_pip
# Recipe:: setup
#
# Copyright 2016, Mapzen
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt::default'

package 'git'
package 'build-essential'

include_recipe "whosonfirst_common::setup_golang"

user_account node[:wof_pip][:user][:name] do
  manage_home   true
  create_group  true
  ssh_keygen    false
  home          node[:wof_pip][:user][:home]
  not_if        { node[:wof_pip][:user][:name] == 'root' }
end

user_ulimit node[:wof_pip][:user][:name] do
  filehandle_limit node[:wof_pip][:user][:filehandles]
end

directory node[:wof_pip][:meta][:dir] do
  recursive true
  owner     node[:wof_pip][:user][:name]
  group     node[:wof_pip][:user][:name]
  mode      0755
end

directory node[:wof_pip][:data][:dir] do
  recursive true
  owner     node[:wof_pip][:user][:name]
  group     node[:wof_pip][:user][:name]
  mode      0755
end

directory node[:wof_pip][:apps][:dir] do
  recursive true
  owner     node[:wof_pip][:user][:name]
  group     node[:wof_pip][:user][:name]
  mode      0755
end

directory node[:wof_pip][:log][:dir] do
  recursive true
  owner     node[:wof_pip][:user][:name]
  group     node[:wof_pip][:user][:name]
  mode      0755
end
