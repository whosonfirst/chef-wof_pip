# apache
#
default[:wof_pip][:apache][:include]            = true # include the apache recipe?

default[:wof_pip][:apache][:docroot]            = '/srv/www'
default[:wof_pip][:apache][:port]               = 9999
default[:wof_pip][:apache][:server_name]        = 'wof-pip'
default[:wof_pip][:apache][:max]                = 20
default[:wof_pip][:apache][:ttl]                = 30
default[:wof_pip][:apache][:acquire]            = 500
default[:wof_pip][:apache][:retrytimeout]       = 3
default[:wof_pip][:apache][:connectiontimeout]  = 3
default[:wof_pip][:apache][:requesttimeout]     = 3
default[:wof_pip][:apache][:base_uri]           = '/'
default[:wof_pip][:apache][:max_age]            = 14_400

default[:apache][:listen_ports]                 = ["#{node[:wof_pip][:apache][:port]}"]
default[:apache][:keepalive]                    = 'On'
default[:apache][:keepaliverequests]            = 0
