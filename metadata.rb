name             'wof_pip'
maintainer       'Mapzen'
maintainer_email 'grant@mapzen.com'
license          'All rights reserved'
description      'Installs/Configures wof_pip'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.7.0'

%w(
  apt
  apache2
  user
  runit
  ulimit
).each do |dep|
  depends dep
end

%w(ubuntu).each do |os|
  supports os
end

depends 'whosonfirst_common', '0.0.1'
