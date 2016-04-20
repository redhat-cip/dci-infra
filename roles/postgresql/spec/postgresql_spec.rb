require 'spec_helper'

describe package('rh-postgresql94-postgresql-server') do
  it { should be_installed }
end

describe service('rh-postgresql94-postgresql') do
  it { should be_enabled }
  it { should be_running }
end

describe port(5432) do
  it { should be_listening }
end
