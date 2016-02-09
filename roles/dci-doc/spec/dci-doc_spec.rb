require 'spec_helper'

describe file('/etc/httpd/conf.d/03_dci_doc.conf') do
  it { should exist }
end
