require 'spec_helper'

describe file('/etc/fail2ban/jail.d/01-sshd.conf') do
  it { should exist }
end

describe file('/etc/fail2ban/jail.d/02-httpd.conf') do
  it { should exist }
end

describe service('fail2ban') do
  it { should be_enabled }
  it { should be_running }
end
