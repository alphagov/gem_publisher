require "gem_publisher/publisher"

module GemPublisher
  def self.publish_if_updated(gemspec, version, method=:rubygems)
    Publisher.new(gemspec, version).publish_if_updated(method)
  end
end
