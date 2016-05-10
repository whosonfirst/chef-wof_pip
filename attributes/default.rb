# setup
#
default[:go][:version] = 1.6

default[:wof_pip][:user][:name]         = 'wof'
default[:wof_pip][:user][:home]         = '/home/wof'
default[:wof_pip][:user][:filehandles]  = 65_536
default[:wof_pip][:meta][:dir]          = '/wof/meta'
default[:wof_pip][:data][:dir]          = '/wof/data'
default[:wof_pip][:apps][:dir]          = '/wof/apps'
default[:wof_pip][:log][:dir]           = '/wof/logs'

# wof-pip-server
#
default[:wof_pip][:server][:repository]     = 'https://github.com/whosonfirst/go-whosonfirst-pip.git'
default[:wof_pip][:server][:revision]       = 'master'
default[:wof_pip][:server][:port]           = 9998
default[:wof_pip][:server][:cache_all]      = true    # if true, ignores cache_size/cache_trigger
default[:wof_pip][:server][:cache_size]     = 10_000  # number of records to cache
default[:wof_pip][:server][:cache_trigger]  = 2000    # number of file record to trigger caching
default[:wof_pip][:server][:bind]           = 'localhost'
default[:wof_pip][:server][:loglevel]       = 'info'

# wof data
#
default[:wof_pip][:data][:purge]          = false
default[:wof_pip][:data][:revision]       = 'master'
default[:wof_pip][:data][:clone_timeout]  = 14_400
default[:wof_pip][:data][:metafiles]      = %w(
  wof-country-latest
  wof-locality-latest
  wof-county-latest
  wof-campus-latest
  wof-localadmin-latest
  wof-microhood-latest
  wof-neighbourhood-latest
  wof-region-latest
  wof-dependency-latest
  wof-macrocounty-latest
  wof-macroregion-latest
)
default[:wof_pip][:data][:source_url] = 'http://s3.amazonaws.com/whosonfirst.mapzen.com'
default[:wof_pip][:data][:meta_url]   = 'https://raw.githubusercontent.com/whosonfirst/whosonfirst-data/master/meta'
