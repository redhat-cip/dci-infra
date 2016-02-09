require 'serverspec'
require 'net/ssh'
require 'yaml'

local_data = YAML.load_file('data/properties.yml')
set_property local_data

if ENV['ASK_SUDO_PASSWORD']
  begin
    require 'highline/import'
  rescue LoadError
    fail "highline is not available. Try installing it."
  end
  set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
else
  set :sudo_password, ENV['SUDO_PASSWORD']
end

host = ENV['TARGET_HOST']

if host == 'functional'
  set :backend, :exec
else
  set :backend, :ssh
end

options = Net::SSH::Config.for(host)

options[:user] ||= ENV['TARGET_USER']
options[:port] ||= ENV['TARGET_PORT']
options[:keys] ||= ENV['TARGET_PRIVATE_KEY']

set :host,        options[:host_name] || host
set :ssh_options, options

# Disable sudo
# set :disable_sudo, true


# Set environment variables
set :env, :LANG => 'en_US.UTF-8', :LC_MESSAGES => 'en_US.UTF-8'

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'
