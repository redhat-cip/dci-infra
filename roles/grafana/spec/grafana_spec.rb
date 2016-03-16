require 'spec_helper'

describe package('grafana') do
  it { should be_installed }
end

describe service('grafana-server') do
  it { should be_enabled }
  it { should be_running }
end
