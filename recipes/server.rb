##
# Cookbook Name:: packetbeat
# Recipe:: server

include_recipe 'java::oracle'

include_recipe 'elasticsearch::default'

include_recipe 'apache2'

remote_file "/tmp/kibana-3.0-packetbeat.tar.gz" do
  source "https://github.com/packetbeat/kibana/releases/download/v3.0.0-pb/kibana-3.0-packetbeat.tar.gz"
end

bash "untar kibana" do
  cwd "/tmp"
  code <<-EOH
  tar -zxf kibana-3.0-packetbeat.tar.gz
  cd kibana-3.0-packetbeat
  mkdir /etc/httpd/htdocs
  cp -R * /etc/httpd/htdocs/
  EOH
end
