require 'spec_helper'

describe package('xinetd') do
  it { should be_installed }
end

describe service('xinetd') do
  it { should be_enabled }
  it { should be_running }
end
