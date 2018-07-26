require 'spec_helper'

describe package('rh-nginx112') do
  it { should be_installed }
end

describe service('rh-nginx112-nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe port(443) do
  it { should be_listening }
end
