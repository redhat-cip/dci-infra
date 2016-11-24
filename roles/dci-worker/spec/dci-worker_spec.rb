require 'spec_helper'

describe file('/etc/supervisord.d/dci-worker.ini') do
  it { should exist }
end

describe package('supervisor') do
  it { should be_installed }
end

describe package('postfix') do
  it { should be_installed }
end

describe service('postfix') do
  it { should be_enabled }
  it { should be_running }
end

describe port(5557) do
  it { should be_listening }
end
