require 'spec_helper'

# Team management
#
describe command("python wrapper.py team-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should contain('admin') }
  its(:stdout) { should_not match("/|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py team-create #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account']}") do
  its(:stdout) { should match("/|\s*name\s*|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py team-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should match("/|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py team-update #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account']} #{property['test_account_updated']}") do
  its(:stdout) { should match("/|\s*message\s*|\s*Team updated.\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py team-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should match("/|\s*#{property['test_account_updated']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py team-delete #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account_updated']}") do
  its(:stdout) { should match("/|\s*message\s*|\s*Team deleted.\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py team-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should_not match("/|\s*#{property['test_account_updated']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py purge #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:exit_status) { should eq 0 }
end
