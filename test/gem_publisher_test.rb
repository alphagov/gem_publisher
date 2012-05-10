require File.expand_path("../common", __FILE__)
require "gem_publisher/publisher"

module GemPublisher
  class PublisherTest < MiniTest::Unit::TestCase
    def test_should_not_do_anything_if_version_has_not_changed
      p = Publisher.new("foo.gemspec", "0.0.2")
      p.builder = mock
      p.builder.expects(:build).never
      p.pusher = mock
      p.pusher.expects(:push).never
      p.git_remote = mock
      p.git_remote.stubs(:tags).returns(%w[v0.0.1 v0.0.2])
      p.git_remote.expects(:add_tag).never
      p.publish_if_updated(:bogus)
    end

    def test_should_build_and_tag_and_publish_if_version_has_changed
      p = Publisher.new("foo.gemspec", "0.0.3")
      p.builder = mock
      p.builder.expects(:build).
        with("foo.gemspec").
        returns("foo-0.0.3.gem")
      p.pusher = mock
      p.pusher.expects(:push).with("foo-0.0.3.gem", :method)
      p.git_remote = mock
      p.git_remote.stubs(:tags).returns(%w[v0.0.1 v0.0.2])
      p.git_remote.expects(:add_tag).with("v0.0.3")
      p.publish_if_updated(:method)
    end

    def test_should_build_and_tag_and_publish_if_there_is_no_released_version
      p = Publisher.new("foo.gemspec", "0.0.3")
      p.builder = mock
      p.builder.expects(:build).returns("foo-0.0.3.gem")
      p.pusher = mock
      p.pusher.expects(:push)
      p.git_remote = mock
      p.git_remote.stubs(:tags).returns([])
      p.git_remote.expects(:add_tag).with("v0.0.3")
      p.publish_if_updated(:method)
    end
  end
end
