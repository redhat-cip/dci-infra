require 'spec_helper'

describe file('/etc/httpd/conf.d/dci.conf') do
  it { should exist }
end
