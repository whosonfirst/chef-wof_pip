name             'wof_pip'
maintainer       'Mapzen'
maintainer_email 'grant@mapzen.com'
license          'All rights reserved'
description      'Installs/Configures wof_pip'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.0'

%w(
  apt
  apache2
  golang
  user
  runit
  ulimit
).each do |dep|
  depends dep
end

%w(ubuntu).each do |os|
  supports os
end

