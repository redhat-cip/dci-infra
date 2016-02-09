require 'spec_helper'

describe file('/etc/yum.repos.d/sensu.repo') do
  it { should exist }
end

describe package('sensu') do
  it { should be_installed }
end

describe package('uchiwa') do
  it { should be_installed }
end

describe service('sensu-server') do
  it { should be_enabled }
  it { should be_running }
end

describe service('sensu-api') do
  it { should be_enabled }
  it { should be_running }
end

describe service('uchiwa') do
  it { should be_enabled }
  it { should be_running }
end

describe port(3000) do
  it { should be_listening }
end

describe port(4567) do
  it { should be_listening }
end
