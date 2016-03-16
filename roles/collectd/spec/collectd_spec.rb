require 'spec_helper'

describe package('collectd') do
  it { should be_installed }
end

describe file('/etc/collectd.d/hostname.conf') do
  it { should exist }
end

describe file('/etc/collectd.d/network.conf') do
  it { should exist }
  it { should contain 'LoadPlugin network' }
end

describe service('collectd') do
  it { should be_enabled }
  it { should be_running }
end
