require 'spec_helper'

# Test management
#
describe command("python wrapper.py test-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should_not match("/|\s*#{property['test_name']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py test-create #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_name']}") do
  its(:stdout) { should match("/|\s*name\s*|\s*#{property['test_name']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py test-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should match("/|\s*#{property['test_name']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py test-delete #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_name_updated']}") do
  its(:stdout) { should match("/|\s*message\s*|\s*Test deleted.\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py test-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should_not match("/|\s*#{property['test_name_updated']}\s*|/") }
  its(:exit_status) { should eq 0 }
end
