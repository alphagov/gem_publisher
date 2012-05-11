lib = File.expand_path("../../lib", __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'rake'
require 'rake/testtask'
require 'gem_publisher'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

task :publish_gem do |t|
  GemPublisher.publish_if_updated "gem_publisher.gemspec", GemPublisher::VERSION, :rubygems
end

task :default => :test
