#
# Cookbook Name:: wof_pip
# Recipe:: data
#
# Copyright 2016, Mapzen
#
# All rights reserved - Do Not Redistribute
#

# purge?
execute 'purge data and meta' do
  user        node[:wof_pip][:user][:name]
  cwd         node[:wof_pip][:data][:dir]
  command <<-EOF
    rm -rf #{node[:wof_pip][:meta][:dir]}/* && rm -rf #{node[:wof_pip][:data][:dir]}/*
  EOF
  only_if { node[:wof_pip][:data][:purge] == true }
end

node[:wof_pip][:data][:metafiles].each do |f|
  remote_file "#{node[:wof_pip][:meta][:dir]}/#{f}.csv" do
    action      :create
    backup      false
    source      "#{node[:wof_pip][:data][:source_url]}/bundles/#{f}.csv"
    owner       node[:wof_pip][:user][:name]
    retries     2
    retry_delay 60
    notifies    :run,     "execute[pull wof data for #{f}]",    :immediately
    notifies    :run,     "execute[extract wof data for #{f}]", :immediately
    notifies    :restart, "runit_service[wof-pip-server]",      :delayed
  end

  execute "pull wof data for #{f}" do
    action      :nothing
    user        node[:wof_pip][:user][:name]
    cwd         node[:wof_pip][:data][:dir]
    retries     2
    retry_delay 60
    command <<-EOF
      wget --quiet -O #{f}.tar.bz2 #{node[:wof_pip][:data][:source_url]}/bundles/#{f.split('-latest').first}-bundle.tar.bz2
    EOF
  end

  execute "extract wof data for #{f}" do
    action      :nothing
    user        node[:wof_pip][:user][:name]
    cwd         node[:wof_pip][:data][:dir]
    retries     2
    retry_delay 60
    command <<-EOF
      bunzip2 #{f}.tar.bz2 && tar xf #{f}.tar --strip-components=2 && rm #{f}.tar
    EOF
  end
end
