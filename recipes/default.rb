#
# Cookbook Name:: packetbeat
# Recipe:: client

yum_package "libpcap"

remote_file "/tmp/packetbeat-0.1.1-1.el6.x86_64.rpm" do
  source "https://github.com/packetbeat/packetbeat/releases/download/v0.1.1/packetbeat-0.1.1-1.el6.x86_64.rpm"
end

remote_file "/tmp/daemonize-1.7.3-1.el6.x86_64.rpm" do
  source "ftp://ftp.hosteurope.de/mirror/fedora-epel/6/x86_64/daemonize-1.7.3-1.el6.x86_64.rpm"
end

rpm_package "daemonize" do
	source "/tmp/daemonize-1.7.3-1.el6.x86_64.rpm"
	action :install
end

rpm_package "packetbeat" do
	source "/tmp/packetbeat-0.1.1-1.el6.x86_64.rpm"
	action :install
end

template "/etc/packetbeat/packetbeat.conf" do
  source "packetbeat.conf.erb"
  mode 00644
  notifies :restart, "service[packetbeat]", :delayed
end

service "packetbeat" do
  supports :restart => true, :reload => true
  action [:enable, :start]
end