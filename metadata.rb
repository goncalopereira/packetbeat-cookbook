name             'packetbeat'
maintainer       'goncalopereira.com'
maintainer_email 'packetbeat@goncalopereira.com'
license          'All rights reserved'
description      'Installs/Configures packetbeat'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "java"

depends "elasticsearch"

depends "apache2"