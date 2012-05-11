require "gem_publisher/publisher"
require "gem_publisher/version"

module GemPublisher

  # Publish a gem based on the supplied gemspec and version via
  # method, iff this version has not already been released and tagged
  # in the origin Git repository.
  #
  # If a remote tag matching the version already exists, nothing is done.
  # Otherwise, the gem is built, pushed, and tagged.
  #
  # Version should be a string of the form "1.2.3". Tags are expected to
  # be of the form "v1.2.3", and generated tags follow this pattern.
  #
  # Method should be one of :rubygems or :gemfury, and the requisite
  # credentials for the corresponding push command line tools must exist.
  #
  def self.publish_if_updated(gemspec, version, method=:rubygems)
    Publisher.new(gemspec, version).publish_if_updated(method)
  end
end
