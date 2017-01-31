require 'spec_helper'

# Component management
#
describe command("python wrapper.py component-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should_not match("/\s*#{property['test_component_name']}\s*/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py component-create #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_component_name']} #{property['test_component_type']}") do
  its(:stdout) { should match("/|\s*name\s*|\s*#{property['test_component_name']}\s*|/") }
  its(:stdout) { should match("/|\s*type\s*|\s*#{property['test_component_type']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py component-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should match("/|\s*#{property['test_component_name']}\s*|/") }
  its(:stdout) { should match("/|\s*#{property['test_component_type']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py component-delete #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_component_name']}") do
  its(:stdout) { should match("/|\s*message\s*|\s*Component deleted.\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py component-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should_not match("/\s*#{property['test_component_name']}\s*/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py purge #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:exit_status) { should eq 0 }
end
