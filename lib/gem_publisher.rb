require "gem_publisher/publisher"
require "gem_publisher/version"

module GemPublisher

  # Publish a gem based on the supplied gemspec via supplied method, iff this
  # version has not already been released and tagged in the origin Git
  # repository.
  #
  # Version is derived from the gemspec.
  #
  # If a remote tag matching the version already exists, nothing is done.
  # Otherwise, the gem is built, pushed, and tagged.
  #
  # Tags are expected to be of the form "v1.2.3", and generated tags follow
  # this pattern.
  #
  # Method should be one of :rubygems or :gemfury, and the requisite
  # credentials for the corresponding push command line tools must exist.
  #
  # Returns the gem file name if a gem was published; nil otherwise. A
  # CliFacade::Error will be raised if a command fails.
  #
  def self.publish_if_updated(gemspec, method=:rubygems)
    Publisher.new(gemspec).publish_if_updated(method)
  end
end
