require 'spec_helper'

describe package('httpd') do
  it { should be_installed }
end

describe service('httpd') do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe file('/var/lib/dci-control-server/files') do
  it { should be_directory }
end

describe file('/var/lib/dci-control-server/files') do
  it { should be_owned_by 'apache' }
  it { should be_grouped_into 'apache' }
  it { should be_writable.by('owner') }
end
