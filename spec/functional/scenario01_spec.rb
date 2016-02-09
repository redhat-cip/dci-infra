require 'spec_helper'

# Scenario01
#
# * Create a team
# * Create a remoteci
# * Create a user
# * Run a github feeder
# * Run the tox agent
# * Check the file content
# * Check the jobstate
# * Remove the user
# * Remove the remoteci
# * Remove the team
#

describe command("python wrapper.py team-create #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account']}") do
  its(:stdout) { should match("/|\s*name\s*|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py team-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should match("/|\s*#{property['test_account']}\s*|/") }
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

describe command("python wrapper.py user-create #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account']} #{property['test_password']}") do
  its(:stdout) { should match("/|\s*name\s*|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py user-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should match("/|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py run-feeder #{property['test_account']} #{property['test_password']} #{property['controlserver_url']} github https://github.com/redhat-cip/python-dciclient") do
  its(:stdout) { should contain("created") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py run-agent #{property['test_account']} #{property['test_password']} #{property['controlserver_url']} tox #{property['test_remoteci_name']} #{property['test_account']}") do
  its(:stdout) { should contain("Job scheduled:") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py jobstate-list #{property['test_account']} #{property['test_password']} #{property['controlserver_url']}") do
  its(:stdout) { should contain("succes") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py file-list #{property['test_account']} #{property['test_password']} #{property['controlserver_url']}") do
  its(:stdout) { should contain("tox") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py component-delete #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} python-dciclient") do
  its(:stdout) { should match("/|\s*message\s*|\s*Component deleted.\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py component-list #{property['test_account']} #{property['test_password']} #{property['controlserver_url']}") do
  its(:stdout) { should_not match("/|\s*python-dciclient\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py user-delete #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account']}") do
  its(:stdout) { should match("/|\s*message\s*|\s*User deleted.\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py user-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should_not match("/|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py remoteci-delete #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_remoteci_name']}") do
  its(:stdout) { should match("/|\s*message\s*|\s*RemoteCI deleted.\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py remoteci-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should_not match("/|\s*#{property['test_remoteci_name']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py team-delete #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']} #{property['test_account']}") do
  its(:stdout) { should match("/|\s*message\s*|\s*Team deleted.\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("python wrapper.py team-list #{property['admin_account']} #{property['admin_password']} #{property['controlserver_url']}") do
  its(:stdout) { should_not match("/|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end
