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
    #allocated_memory '256m'
    jvm_options ['-Xms1512M','-Xmx1512M']
    configuration ({
    'cluster.name' => 'elasticsearch',
    'node.name' => 'nodeES01',
    'network.host' => '0.0.0.0'
    'path.repo' => '/etc/elasticsearch/backupsudo'
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
  command 'grafana-cli plugins install jdbranham-diagram-panel'
end

execute 'install Grafana Plugins' do
  command 'sudo grafana-cli plugins install jdbranham-diagram-panel'
  command 'sudo grafana-cli plugins install grafana-piechart-panel'
  command 'sudo grafana-cli plugins install savantly-heatmap-panel'
  command 'sudo grafana-cli plugins install natel-plotly-panel'
  command 'sudo grafana-cli plugins install bessler-pictureit-panel'
  command 'sudo  grafana-cli plugins install briangann-datatable-panel'
  command 'git clone https://github.com/TalentSoft/grafana-datatable-panel.git -- /var/lib/grafana/plugins/grafana-datatable-panel'
  command 'git clone https://github.com/abmptit/WebTestsDashboard-app.git -- /var/lib/grafana/plugins/WebTestsDashboard-app'
  command 'sudo /bin/systemctl restart grafana-server'
end