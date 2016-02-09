require 'spec_helper'

describe file('/etc/httpd/conf.d/02_dci_repo.conf') do
  it { should exist }
end
