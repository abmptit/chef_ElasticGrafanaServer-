#
# Cookbook:: chef_ElasticGrafanaServer
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'java'

git_client 'default' do
  action :install
end

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
    jvm_options ['-Xms1512M','-Xmx1512M']
    configuration ({
    'cluster.name' => 'elasticsearch',
    'node.name' => 'nodeES01',
    'network.host' => '0.0.0.0',
    'path.repo' => '/etc/elasticsearch/backup'
    })
end

elasticsearch_service 'elasticsearch' do
    service_actions [:enable, :start]
end

remote_file '/home/grafana_4.1.1-1484211277_amd64.deb' do
  source 'https://grafanarel.s3.amazonaws.com/builds/grafana_4.1.1-1484211277_amd64.deb'
  mode '0755'
  action :create
end

dpkg_package 'grafana' do
   action :install
   source '/home/grafana_4.1.1-1484211277_amd64.deb'
end

execute 'install jdbranham-diagram-panel' do
  command 'sudo grafana-cli plugins install jdbranham-diagram-panel'
 end

execute 'install grafana-piechart-panel' do
  command 'sudo grafana-cli plugins install grafana-piechart-panel'
 end

execute 'install savantly-heatmap-panel' do
  command 'sudo grafana-cli plugins install savantly-heatmap-panel'
 end

execute 'install natel-plotly-panel' do
  command 'sudo grafana-cli plugins install natel-plotly-panel'
 end

 execute 'install bessler-pictureit-panel' do
  command 'sudo grafana-cli plugins install bessler-pictureit-panel'
 end

 execute 'install briangann-datatable-panel' do
  command 'sudo grafana-cli plugins install briangann-datatable-panel'
 end

execute 'install ts-datatable-panel' do
    command 'git clone https://github.com/TalentSoft/grafana-datatable-panel.git -- /var/lib/grafana/plugins/ts-datatable-panel'
 end

execute 'restart grafana-server' do
    command 'sudo /bin/systemctl restart grafana-server'
 end

execute 'install sqlite' do
  command 'sudo apt install sqlite3'
end
