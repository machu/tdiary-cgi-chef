#
# Cookbook Name:: tdiary
# Recipe:: default
#
# see: http://heartbeats.jp/hbblog/2013/01/chef-cookbook-tips.html
version = 'v4.0.0'
archive = "tdiary-#{version}.tar.gz"
install_dir = "/var/www"

remote_file "#{Chef::Config[:file_cache_path]}/#{archive}" do
	source "http://www.tdiary.org/download/#{archive}"
	action :create_if_missing
end

script "install_tdiary" do
	interpreter "bash"
	user        "root"
	flags "-e"
	code <<-EOL
		install -d #{install_dir}
		tar zxvf #{Chef::Config[:file_cache_path]}/#{archive} -C #{install_dir}
		chown -R www-data:www-data #{install_dir}/tdiary-#{version}
	EOL
end

cookbook_file "#{install_dir}/tdiary-#{version}/tdiary.conf" do
	owner "www-data"
	group "www-data"
	mode 0644
end

template "#{install_dir}/tdiary-#{version}/.htaccess" do
	owner "www-data"
	group "www-data"
	mode 0644
	source "dot.htaccess"
end
