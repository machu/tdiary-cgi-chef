#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "apache2" do
	action :install
end

service "apache2" do
	supports :status => true, :restart => true, :reload => true
	action [:enable, :start]
end

template "/etc/apache2/sites-available/default" do
	owner "root"
	group "root"
	mode  0644
	notifies :reload, "service[apache2]"
end

package "ruby1.9.3" do
	action :install
end
