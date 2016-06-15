require 'spec_helper'

describe package('python-psycopg2') do
  it { should be_installed }
end

describe file('/etc/httpd/conf.d/dci_api.conf') do
  it { should exist }
end

describe file("#{property['api_filestore_path']}") do
  it { should be_directory }
end

describe file("#{property['api_filestore_path']}") do
  it { should be_owned_by 'apache' }
  it { should be_grouped_into 'apache' }
  it { should be_writable.by('owner') }
end
