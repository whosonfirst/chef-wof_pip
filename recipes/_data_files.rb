#
# Cookbook Name:: wof_pip
# Recipe:: data
#
# Copyright 2016, Mapzen
#
# All rights reserved - Do Not Redistribute
#

# increase proc count if this is the initial data pull
#
node.set[:wof_pip][:clone][:procs] = 25 unless ::File.exist?(node[:wof_pip][:data][:initial_run_complete_file])

# purge?
execute 'purge data and meta' do
  user        node[:wof_pip][:user][:name]
  cwd         node[:wof_pip][:data][:dir]
  command <<-EOF
    rm -rf #{node[:wof_pip][:meta][:dir]}/* && rm -rf #{node[:wof_pip][:data][:dir]}/*
  EOF
  only_if { node[:wof_pip][:data][:purge] == true }
end

# wof clone
#
git "#{node[:wof_pip][:apps][:dir]}/whosonfirst-clone" do
  user        node[:wof_pip][:user][:name]
  repository  node[:wof_pip][:clone][:repository]
  revision    node[:wof_pip][:clone][:revision]
  notifies    :run, 'execute[compile wof clone]', :immediately
  retries     2
  retry_delay 60
end

execute 'compile wof clone' do
  action      :nothing
  user        node[:wof_pip][:user][:name]
  cwd         "#{node[:wof_pip][:apps][:dir]}/whosonfirst-clone"
  command     'make deps && make bin'
  retries     2
  retry_delay 60
  environment(
    'HOME'    => node[:wof_pip][:user][:home],
    'PATH'    => '/bin:/usr/bin:/sbin:/usr/bin:/usr/local/go/bin:/opt/go/bin',
    'GOBIN'   => '/opt/go/bin',
    'GOPATH'  => "#{node[:wof_pip][:apps][:dir]}/whosonfirst-clone"
  )
end

node[:wof_pip][:data][:metafiles].each do |f|
  remote_file "#{node[:wof_pip][:meta][:dir]}/#{f}.csv" do
    action      :create
    backup      false
    source      "#{node[:wof_pip][:data][:meta_url]}/#{f}.csv"
    owner       node[:wof_pip][:user][:name]
    retries     2
    retry_delay 60
    notifies    :run, "execute[pull wof data for #{f}]", :immediately
    notifies    :restart, "runit_service[wof-pip-server]", :delayed
  end

  execute "pull wof data for #{f}" do
    action      :nothing
    user        node[:wof_pip][:user][:name]
    cwd         "#{node[:wof_pip][:apps][:dir]}/whosonfirst-clone"
    retries     2
    retry_delay 60
    timeout     node[:wof_pip][:data][:clone_timeout]
    command <<-EOF
      ./bin/wof-clone-metafiles \
        -force-updates \
        -source #{node[:wof_pip][:data][:source_url]}/data/ \
        -procs #{node[:wof_pip][:clone][:procs]} \
        -loglevel #{node[:wof_pip][:clone][:loglevel]} \
        -dest #{node[:wof_pip][:data][:dir]} \
        #{node[:wof_pip][:meta][:dir]}/#{f}.csv >#{node[:wof_pip][:log][:dir]}/wof_data_#{f}.log 2>&1
    EOF
    environment(
      'HOME'    => node[:wof_pip][:user][:home],
      'PATH'    => '/bin:/usr/bin:/sbin:/usr/bin:/usr/local/go/bin:/opt/go/bin',
      'GOBIN'   => '/opt/go/bin',
      'GOPATH'  => "#{node[:wof_pip][:apps][:dir]}/whosonfirst-clone"
    )
  end
end
