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
  cp -R * /var/www/html
  EOH
end

link "/etc/httpd/sites-available/default" do
  to "/etc/httpd/sites-enabled/default"
  notifies :restart, "service[httpd]", :delayed
end

service "httpd" do
  supports :restart => true, :reload => true
  action [:enable, :start]
end