require 'spec_helper'

describe package('collectd') do
  it { should be_installed }
end

describe file('/etc/collectd.d/network.conf') do
  it { should exist }
  it { should contain 'LoadPlugin network' }
end
