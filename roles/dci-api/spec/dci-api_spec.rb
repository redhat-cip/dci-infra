require 'spec_helper'

describe package('python-psycopg2') do
  it { should be_installed }
end

describe file('/etc/httpd/conf.d/dci_api.conf') do
  it { should exist }
end
