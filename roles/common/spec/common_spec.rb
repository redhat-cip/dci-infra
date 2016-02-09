require 'spec_helper'

describe file('/etc/selinux/config') do
  its(:content) { should match /^SELINUX=enforcing$/ }
end

describe file('/etc/yum.repos.d/epel.repo') do
  it { should exist }
end

describe package('dci-sshpubkeys') do
  it { should be_installed }
end

describe file('/etc/sudoers.d/dci-user') do
  it { should contain 'dci ALL=(ALL) NOPASSWD:ALL' }
end
