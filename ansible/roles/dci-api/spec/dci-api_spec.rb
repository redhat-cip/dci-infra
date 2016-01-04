require 'spec_helper'

describe package('python-psycopg2') do
  it { should be_installed }
end
