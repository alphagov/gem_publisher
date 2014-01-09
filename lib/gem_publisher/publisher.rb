require "gem_publisher/git_remote"
require "gem_publisher/builder"
require "gem_publisher/pusher"
require "rubygems/specification"

module GemPublisher
  class Publisher
    attr_accessor :git_remote, :builder, :pusher
    attr_reader :version

    def initialize(gemspec)
      @gemspec = gemspec

      @version = eval(File.read(gemspec), TOPLEVEL_BINDING).version.to_s

      @git_remote = GitRemote.new
      @builder    = Builder.new
      @pusher     = Pusher.new
    end

    def publish_if_updated(method, options = {})
      return if version_released?
      @builder.build(@gemspec).tap { |gem|
        @pusher.push gem, method, options
        @git_remote.add_tag "v#@version"
      }
    end

    def version_released?
      releases = @git_remote.tags.
        select { |t| t =~ /^v\d+(\.\d+)+/ }.
        map { |t| t.scan(/\d+/).map(&:to_i) }
      this_release = @version.split(/\./).map(&:to_i)
      releases.include?(this_release)
    end
  end
end
