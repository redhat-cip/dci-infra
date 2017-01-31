require 'spec_helper'

# User Management
#
describe command("python wrapper.py team-create #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account']}") do
  its(:stdout) { should match("/|\s*name\s*|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py remoteci-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should_not match("/#{property['test_remoteci_name']}/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py remoteci-create #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_remoteci_name']} #{property['test_password']}") do
  its(:stdout) { should match("/|\s*name\s*|\s*#{property['test_remoteci_name']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py remoteci-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should match("/|\s*#{property['test_remoteci_name']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py remoteci-update #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_remoteci_name']} #{property['test_remoteci_name_updated']}") do
  its(:stdout) { should match("/|\s*message\s*|\s*RemoteCI updated.\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py remoteci-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should match("/|\s*#{property['test_remoteci_name_updated']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py remoteci-delete #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_remoteci_name_updated']}") do
  its(:stdout) { should match("/|\s*message\s*|\s*RemoteCI deleted.\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py team-delete #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account']}") do
  its(:stdout) { should match("/|\s*message\s*|\s*Team deleted.\s*|/") }
  its(:exit_status) { should eq 0 }
end
