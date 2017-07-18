#
# Cookbook:: chef_ElasticGrafanaServer
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'java'

elasticsearch_user 'elasticsearch' do
  username 'elasticsearch'
  groupname 'elasticsearch'
  shell '/bin/bash'
  comment 'Elasticsearch User'

  action :create
end

elasticsearch_install 'elasticsearch' do
version "5.2.2"
action :install
end

elasticsearch_configure 'elasticsearch' do
allocated_memory '256m'
configuration ({
'cluster.name' => 'mycluster',
'node.name' => 'node01'
})
end

elasticsearch_service 'elasticsearch' do
service_actions [:enable, :start]
end