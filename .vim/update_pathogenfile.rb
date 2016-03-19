#!/usr/bin/env ruby
bundle_path = File.join(ENV['HOME'], '.vim/bundle')
installed_plugins = Dir.entries(bundle_path).select do |plugin|
  plugin_path = File.join(bundle_path, plugin)
  # Is it really a git repo
  File.directory? plugin_path and %x[ls -A #{plugin_path}].split("\n").include? ".git"
end.map do |plugin| 
  plugin_path = File.join(bundle_path, plugin)
  Dir.chdir(plugin_path)
  remote = %x[git remote -v | grep fetch].split("\n").map{|i| i.gsub(/\s+/m, ' ').strip.split(" ")[1]}.uniq.first
end

Dir.chdir(bundle_path)
pathogenfile_path = File.join(ENV['HOME'], '.vim/bundle/Pathogenfile')
defined_plugins = %x[touch #{pathogenfile_path}; cat #{pathogenfile_path}].split("\n")

# Install those plugins which are defined
need_to_be_installed = defined_plugins - installed_plugins
need_to_be_installed.each do |plugin|
  %x[git clone #{plugin}]
end

# Define those plugins which are installed
need_to_be_defined = installed_plugins - defined_plugins
need_to_be_defined.each do |plugin|
  %x[echo #{plugin} >> #{pathogenfile_path}]
end
