#
# Cookbook Name:: wof_pip
# Recipe:: data
#
# Copyright 2016, Mapzen
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'wof_pip::setup'

# wof clone
#
git "#{node[:wof_pip][:apps][:dir]}/whosonfirst-clone" do
  user        node[:wof_pip][:user][:name]
  repository  node[:wof_pip][:clone][:repository]
  revision    node[:wof_pip][:clone][:revision]
  notifies    :run, 'execute[compile wof clone]', :immediately
  retries     1
  retry_delay 300
end

execute 'compile wof clone' do
  action      :nothing
  user        node[:wof_pip][:user][:name]
  cwd         "#{node[:wof_pip][:apps][:dir]}/whosonfirst-clone"
  command     'make deps && make bin'
  retries     1
  retry_delay 300
  environment(
    'HOME'    => node[:wof_pip][:user][:home],
    'PATH'    => '/bin:/usr/bin:/sbin:/usr/bin:/usr/local/go/bin:/opt/go/bin',
    'GOBIN'   => '/opt/go/bin',
    'GOPATH'  => "#{node[:wof_pip][:apps][:dir]}/whosonfirst-clone"
  )
end

node[:wof_pip][:data][:metafiles].each do |f|
      Chef::Log.info("RUNNING THE FOLLOWING: ./bin/wof-clone-metafiles -strict -loglevel #{node[:wof_pip][:clone][:loglevel]} -dest #{node[:wof_pip][:data][:dir]} #{node[:wof_pip][:data][:dir]}/#{f} >#{node[:wof_pip][:log][:dir]}/logs/pull_wof_data.log 2>&1")
  execute "retrieve meta file #{f}" do
    user        node[:wof_pip][:user][:name]
    cwd         node[:wof_pip][:data][:dir]
    retries     1
    retry_delay 300
    command <<-EOF
      curl -s -o #{f} #{node[:wof_pip][:data][:raw_url]}/#{f}
    EOF
  end

  execute "pull wof data for #{f}" do
    user        node[:wof_pip][:user][:name]
    cwd         "#{node[:wof_pip][:apps][:dir]}/whosonfirst-clone"
    retries     1
    retry_delay 300
    timeout     node[:wof_pip][:data][:clone_timeout]
    command <<-EOF
      ./bin/wof-clone-metafiles -strict -loglevel #{node[:wof_pip][:clone][:loglevel]} -dest #{node[:wof_pip][:data][:dir]} #{node[:wof_pip][:data][:dir]}/#{f} >#{node[:wof_pip][:log][:dir]}/logs/pull_wof_data.log 2>&1
    EOF
    environment(
      'HOME'    => node[:wof_pip][:user][:home],
      'PATH'    => '/bin:/usr/bin:/sbin:/usr/bin:/usr/local/go/bin:/opt/go/bin',
      'GOBIN'   => '/opt/go/bin',
      'GOPATH'  => "#{node[:wof_pip][:apps][:dir]}/whosonfirst-clone"
    )
  end
end

runit_service 'wof-pip-server' do
  action :restart
  only_if { ::File.exist?('/etc/service/wof-pip-server') }
end

execute 'wait for wof service' do
  user        node[:wof_pip][:user][:name]
  timeout     node[:wof_pip][:server][:wait_time]
  retries     node[:wof_pip][:server][:wait_time]
  retry_delay 1
  command <<-EOF
    curl -s -o /dev/null "http://#{node[:wof_pip][:server][:bind]}:#{node[:wof_pip][:server][:port]}?latitude=40.677524&longitude=-73.987343"
  EOF
end
