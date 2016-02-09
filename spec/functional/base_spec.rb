require 'spec_helper'

describe command('dcictl --help') do
  its(:exit_status) { should eq 0 }
end
