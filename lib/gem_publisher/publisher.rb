require "gem_publisher/git_remote"
require "gem_publisher/builder"
require "gem_publisher/pusher"
require "rubygems/specification"

module GemPublisher
  class Publisher
    attr_accessor :git_remote, :builder, :pusher

    def initialize(gemspec)
      @gemspec = gemspec

      @version = eval(File.read(gemspec)).version.to_s

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

  private
    def version_released?
      releases = @git_remote.tags.
        select { |t| t =~ /^v\d+(\.\d+)+/ }.
        map { |t| t.scan(/\d+/).map(&:to_i) }
      this_release = @version.split(/\./).map(&:to_i)
      releases.include?(this_release)
    end

    def tag_remote
      return
      sha1 = `git rev-parse HEAD`
      system "git update-ref refs/tags/v#@version #{sha1}"
      system "git push origin tag v#@version"
    end
  end
end
