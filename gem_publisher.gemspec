require File.expand_path('../lib/gem_publisher/version', __FILE__)

gemspec = Gem::Specification.new do |s|
  s.name              = 'gem_publisher'
  s.version           = GemPublisher::VERSION
  s.summary           = 'Automatically build, tag, and push gems'
  s.description       = 'Automatically build, tag, and push a gem when its version has been updated.'
  s.files             = Dir.glob("{lib,test}/**/*")
  s.require_path      = 'lib'
  s.has_rdoc          = true
  s.homepage          = 'http://github.com/alphagov/gem_publisher'
  s.authors           = ['Paul Battley']
  s.email             = "pbattley@gmail.com"
end
