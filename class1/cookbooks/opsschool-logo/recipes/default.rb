#
# Cookbook:: opsschool-logo
# Recipe:: default
#
apt_update

package 'nginx'

directory '/opt/opsschool' do
  owner node[:logo][:user]
  group node[:logo][:user]
  action :create
end

cookbook_file '/opt/opsschool/index.html' do
  source 'logo.html'
  owner node[:logo][:user]
  group node[:logo][:user]  
  action :create
end

remote_file 'opt/opsschool/logo.png' do
  source node[:logo][:logo_url]
  owner node[:logo][:user]
  group node[:logo][:user]
  action :create
end

file '/etc/nginx/sites-enabled/default' do
  action :delete
end

template '/etc/nginx/sites-available/logo' do
  source 'logo.nginx-conf.erb'
end

link '/etc/nginx/sites-enabled/logo' do
  to '/etc/nginx/sites-available/logo'
  link_type :symbolic
end

service 'nginx' do
  action :restart
end
