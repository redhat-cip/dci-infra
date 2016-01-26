require 'spec_helper'

describe command('dcictl --help') do
  its(:exit_status) { should eq 0 }
end

# Team management
#
describe command("./wrapper.sh team-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should contain('admin') }
  its(:stdout) { should_not match("/|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("./wrapper.sh team-create #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account']}") do
  its(:stdout) { should match("/|\s*name\s*|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("./wrapper.sh team-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should match("/|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("./wrapper.sh team-update #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account']} #{property['test_account_updated']}") do
  its(:stdout) { should match("/|\s*message\s*|\s*Team updated.\s*|/") }
  its(:stdout) { should match("/|\s*name\s*|\s*#{property['test_account_updated']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("./wrapper.sh team-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should match("/|\s*#{property['test_account_updated']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("./wrapper.sh team-delete #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account_updated']}") do
  its(:stdout) { should match("/|\s*message\s*|\s*Team deleted.\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("./wrapper.sh team-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should_not match("/|\s*#{property['test_account_updated']}\s*|/") }
  its(:exit_status) { should eq 0 }
end


# User Management
#
describe command("./wrapper.sh team-create #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account']}") do
  its(:stdout) { should match("/|\s*name\s*|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("./wrapper.sh user-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should contain('admin') }
  its(:stdout) { should_not match("/|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("./wrapper.sh user-create #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account']} #{property['test_password']}") do
  its(:stdout) { should match("/|\s*name\s*|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("./wrapper.sh user-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should match("/|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("./wrapper.sh user-update #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account']} #{property['test_account_updated']}") do
  its(:stdout) { should match("/|\s*message\s*|\s*User updated.\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("./wrapper.sh user-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should match("/|\s*#{property['test_account_updated']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("./wrapper.sh user-delete #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account_updated']}") do
  its(:stdout) { should match("/|\s*message\s*|\s*User deleted.\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("./wrapper.sh team-delete #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account']}") do
  its(:stdout) { should match("/|\s*message\s*|\s*Team deleted.\s*|/") }
  its(:exit_status) { should eq 0 }
end
