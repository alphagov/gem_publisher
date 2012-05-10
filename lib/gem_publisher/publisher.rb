require "gem_publisher/git_remote"
require "gem_publisher/builder"
require "gem_publisher/pusher"

module GemPublisher
  class Publisher
    attr_accessor :git_remote, :builder, :pusher

    def initialize(gemspec, version)
      @gemspec = gemspec
      @version = version
      @git_remote = GitRemote.new
      @builder    = Builder.new
      @pusher     = Pusher.new
    end

    def publish_if_updated(method)
      return unless version_bumped?
      gem = @builder.build(@gemspec)
      @pusher.push gem, method
      @git_remote.add_tag "v#@version"
    end

  private
    def version_bumped?
      last_release = @git_remote.tags.
        select { |t| t =~ /^v\d+(\.\d+)+/ }.
        map { |t| t.scan(/\d+/).map(&:to_i) }.
        sort.last
      this_release = @version.split(/\./).map(&:to_i)
      this_release != last_release
    end

    def tag_remote
      return
      sha1 = `git rev-parse HEAD`
      system "git update-ref refs/tags/v#@version #{sha1}"
      system "git push origin tag v#@version"
    end
  end
end
