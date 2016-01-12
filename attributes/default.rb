# setup
#
default[:go][:version] = 1.5

default[:wof_pip][:user][:name]         = 'wof'
default[:wof_pip][:user][:home]         = '/home/wof'
default[:wof_pip][:user][:filehandles]  = 65_536
default[:wof_pip][:meta][:dir]          = '/wof/meta'
default[:wof_pip][:data][:dir]          = '/wof/data'
default[:wof_pip][:apps][:dir]          = '/wof/apps'
default[:wof_pip][:log][:dir]           = '/wof/logs'

# wof-pip-server
#
default[:wof_pip][:server][:repository] = 'https://github.com/whosonfirst/go-whosonfirst-pip.git'
default[:wof_pip][:server][:revision]   = 'master'
default[:wof_pip][:server][:port]       = 9999
default[:wof_pip][:server][:cache]      = 50_000
default[:wof_pip][:server][:bind]       = 'localhost'

# wof clone
#
default[:wof_pip][:clone][:repository]  = 'https://github.com/whosonfirst/go-whosonfirst-clone.git'
default[:wof_pip][:clone][:revision]    = 'master'
default[:wof_pip][:clone][:loglevel]    = 'info'
default[:wof_pip][:clone][:procs]       = node[:cpu][:total] * 4

# wof data
#
default[:wof_pip][:data][:revision]       = 'master'
default[:wof_pip][:data][:clone_timeout]  = 14_400
default[:wof_pip][:data][:metafiles]      = %w(
  wof-country-latest.csv
  wof-locality-latest.csv
  wof-county-latest.csv
  wof-localadmin-latest.csv
  wof-neighborhood-latest.csv
  wof-region-latest.csv
)
default[:wof_pip][:data][:raw_url]    = 'https://raw.githubusercontent.com/whosonfirst/whosonfirst-data/master/meta'
