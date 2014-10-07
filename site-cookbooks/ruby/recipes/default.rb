#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


package "ruby" do
 action :install
end

directory "/home/vagrant/.rbenv" do
  owner "vagrant"
  group "vagrant"
  mode 0711
  action :create
end

git "/home/vagrant/.rbenv" do
  repository "git://github.com/sstephenson/rbenv.git"
  reference "master"
  action :checkout
  user "vagrant"
  group "vagrant"
end

%w{ /home/vagrant/.rbenv/plugins/ /home/vagrant/.rbenv/plugins/ruby-build }.each do |dir|
  directory dir do
    owner "vagrant"
    group "vagrant"
    mode 0711
    action :create
  end
end

git "/home/vagrant/.rbenv/plugins/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
  reference "master"
  action :checkout
  user "vagrant"
  group "vagrant"
end

bash "init rbenv" do
  code <<-EOS
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bash_profile
    echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bash_profile
    sudo /home/vagrant/.rbenv/plugins/ruby-build/install.sh
  EOS
  not_if "grep 'rbenv' /home/vagrant/.bash_profile"
end

# rbenv install 2.1.1
# rbenv global 2.1.1
# exec $SHELL -l





