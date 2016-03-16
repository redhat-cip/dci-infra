require 'spec_helper'

describe package('influxdb') do
  it { should be_installed }
end

describe port('25286') do
  it { should be_listening.with('udp') }
end
