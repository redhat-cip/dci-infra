require 'spec_helper'

describe package('influxdb') do
  it { should be_installed }
end

describe service('influxdb') do
  it { should be_enabled }
  it { should be_running }
end
