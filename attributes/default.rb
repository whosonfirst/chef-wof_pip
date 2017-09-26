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
default[:wof_pip][:server][:repository]     = 'https://github.com/whosonfirst/go-whosonfirst-pip-v2.git'
default[:wof_pip][:server][:revision]       = 'master'
default[:wof_pip][:server][:port]           = 9998
default[:wof_pip][:server][:cache_all]      = true    # if true, ignores cache_size/cache_trigger
default[:wof_pip][:server][:cache_size]     = 10000  # number of records to cache
default[:wof_pip][:server][:cache_trigger]  = 2000    # number of file record to trigger caching
default[:wof_pip][:server][:bind]           = 'localhost'
default[:wof_pip][:server][:loglevel]       = 'info'

# wof data
#
default[:wof_pip][:data][:purge]          = false
default[:wof_pip][:data][:revision]       = 'master'
default[:wof_pip][:data][:clone_timeout]  = 14_400
default[:wof_pip][:data][:metafiles]      = %w(
  wof-borough-latest
  wof-campus-latest
  wof-country-latest
  wof-county-latest
  wof-dependency-latest
  wof-disputed-latest
  wof-intersection-us-ny
  wof-localadmin-latest
  wof-locality-latest
  wof-macrocounty-latest
  wof-macrohood-latest
  wof-macroregion-latest
  wof-microhood-latest
  wof-neighbourhood-latest
  wof-postalcode-ca-latest
  wof-postalcode-au-latest
  wof-postalcode-us-latest
  wof-region-latest
)
default[:wof_pip][:data][:source_url] = 'http://s3.amazonaws.com/whosonfirst.mapzen.com'
default[:wof_pip][:data][:meta_url]   = 'https://s3.amazonaws.com/whosonfirst.mapzen.com/bundles'

# this is still here in case the URL above doesn't work - it is necessary for the addition of
# postalcodes in default[:wof_pip][:data][:metafiles] above (20170125/thisisaaronland)
# default[:wof_pip][:data][:meta_url]  = 'https://raw.githubusercontent.com/whosonfirst/whosonfirst-data/master/meta'
