require 'spec_helper'

describe file('/etc/httpd/conf.d/dci_ui.conf') do
  it { should exist }
end
