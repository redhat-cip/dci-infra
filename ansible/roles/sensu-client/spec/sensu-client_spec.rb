require 'spec_helper.rb'

describe file('/etc/yum.repos.d/sensu.repo') do
  it { should exist }
end

describe package('sensu') do
  it { should be_installed }
end

describe service('sensu-client') do
  it { should be_enabled }
  it { should be_running }
end
