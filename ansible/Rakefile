require 'rake'
require 'rspec/core/rake_task'
require 'yaml'
require 'ansible_spec'

properties = AnsibleSpec.get_properties

namespace :serverspec do
  desc "Run serverspec for functional testing"
  RSpec::Core::RakeTask.new(:functional) do |t|
    puts "Run serverspec for functional testing"
    ENV['TARGET_HOST'] = 'functional'
    t.pattern = "spec/functional/*_spec.rb"
  end
end

namespace :serverspec do
  properties.each do |property|
    property["hosts"].each do |host|
      desc "Run serverspec for #{property["name"]}"
      RSpec::Core::RakeTask.new(property["name"].to_sym) do |t|
        puts "Run serverspec for #{property["name"]} to #{host}"
        ENV['TARGET_HOST'] = host["uri"]
        ENV['TARGET_PORT'] = host["port"].to_s
        ENV['TARGET_PRIVATE_KEY'] = host["private_key"]
        unless host["user"].nil?
          ENV['TARGET_USER'] = host["user"]
        else
          ENV['TARGET_USER'] = property["user"]
        end

        roles = property["roles"]
        for role in property["roles"]
          deps = AnsibleSpec.load_dependencies(role)
          roles += deps
        end
        t.pattern = 'roles/{' + roles.join(',') + '}/spec/*_spec.rb'
      end
    end
  end
end
