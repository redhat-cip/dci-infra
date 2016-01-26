require 'spec_helper'

describe command('dcictl --help') do
  its(:exit_status) { should eq 0 }
end

# Team management
#
describe command("dcictl --dci-login=#{property['admin_account']} --dci-password=#{property['admin_password']} --dci-cs-url=#{property['controlserver_url']} team-list") do
  its(:stdout) { should contain('admin') }
  its(:stdout) { should_not match("/|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("dcictl --dci-login=#{property['admin_account']} --dci-password=#{property['admin_password']} --dci-cs-url=#{property['controlserver_url']} team-create --name #{property['test_account']}") do
  its(:stdout) { should match("/|\s*name\s*|\s*#{property['test_account']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("$(dcictl --dci-login=#{property['admin_account']} --dci-password=#{property['admin_password']} --dci-cs-url=#{property['controlserver_url']} team-list | grep -E '/\|\s*#{property['test_account']}\s*\|/' | sed s'#|\s*\(.*\)\s*|\s*spredzy\s*|\s*\([^|]*\).*#dcictl --dci-login=#{property['admin_account']} --dci-password=#{property['admin_password']} --dci-cs-url=#{property['controlserver_url']} team-update --id \1--etag \2 --name #{property['admin_account']}#g')") do
  its(:stdout) { should match("/|\s*message\s*|\s*Team updated.\s*|/") }
  its(:stdout) { should match("/|\s*name\s*|\s*#{property['test_account_updated']}\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("dcictl --dci-login=#{property['admin_account']} --dci-password=#{property['admin_password']} --dci-cs-url=#{property['controlserver_url']} team-list") do
  its(:stdout) { should contain("#{property['test_account_updated']}") }
  its(:exit_status) { should eq 0 }
end

describe command("$(dcictl --dci-login=#{property['admin_account']} --dci-password=#{property['admin_password']} --dci-cs-url=#{property['controlserver_url']} team-list | grep -E '\|\s*#{property['test_account_updated']}\s*\|' | sed s'/|\s*\(.*\)\s*|\s*spredzy\s*|\s*\([^|]*\).*/dcictl --dci-login=#{property['admin_account']} --dci-password=#{property['admin_password']} --dci-cs-url=#{property['controlserver_url']} team-delete --id \1--etag \2/g')") do
  its(:stdout) { should match("/|\s*message\s*|\s*Team deleted.\s*|/") }
  its(:exit_status) { should eq 0 }
end

describe command("dcictl --dci-login=#{property['admin_account']} --dci-password=#{property['admin_password']} --dci-cs-url=#{property['controlserver_url']} team-list") do
  its(:stdout) { should_not contain("#{property['test_account_updated']}") }
  its(:exit_status) { should eq 0 }
end
