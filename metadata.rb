name 'chef_ElasticGrafanaServer'
maintainer 'Aymen BEN MILED'
maintainer_email 'aben-miled@talentsoft.com'
license 'All Rights Reserved'
description 'Installs/Configures chef_ElasticGrafanaServer'
long_description 'Installs/Configures chef_ElasticGrafanaServer'
version '0.1.1'
chef_version '>= 12.1' if respond_to?(:chef_version)

supports 'ubuntu'

#depends 'firewall'
depends 'git'
depends 'java'
depends 'elasticsearch'
depends 'openjdk'
depends 'chef-grafana'
depends 'packagecloud'
