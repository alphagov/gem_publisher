lib = File.expand_path("../lib", __FILE__)
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
  gem = GemPublisher.publish_if_updated("gem_publisher.gemspec", GemPublisher::VERSION, :rubygems)
  puts "Published #{gem}" if gem
end

task :default => :test
