require File.expand_path("../common", __FILE__)
require "gem_publisher/publisher"

module GemPublisher
  class PublisherTest < MiniTest::Unit::TestCase
    def test_should_not_do_anything_and_return_nil_if_version_has_not_changed
      p = Publisher.new(data_file_path("example.gemspec"))
      p.builder = mock
      p.builder.expects(:build).never
      p.pusher = mock
      p.pusher.expects(:push).never
      p.git_remote = mock
      p.git_remote.stubs(:tags).returns(%w[v0.0.1 v0.0.2 v0.0.3])
      p.git_remote.expects(:add_tag).never
      assert_nil p.publish_if_updated(:bogus)
    end

    def test_should_not_do_anything_and_return_nil_if_version_has_already_been_tagged_even_with_a_later_tag
      p = Publisher.new(data_file_path("example.gemspec"))
      p.builder = mock
      p.builder.expects(:build).never
      p.pusher = mock
      p.pusher.expects(:push).never
      p.git_remote = mock
      p.git_remote.stubs(:tags).returns(%w[v0.0.1 v0.0.2 v0.0.3 v0.1.0])
      p.git_remote.expects(:add_tag).never
      assert_nil p.publish_if_updated(:bogus)
    end

    def test_should_build_and_tag_and_publish_and_return_gem_name_if_version_has_changed
      gemspec = data_file_path("example.gemspec")
      p = Publisher.new(gemspec)
      p.builder = mock
      p.builder.expects(:build).
        with(gemspec).
        returns("foo-0.0.3.gem")
      p.pusher = mock
      p.pusher.expects(:push).with("foo-0.0.3.gem", :method, {})
      p.git_remote = mock
      p.git_remote.stubs(:tags).returns(%w[v0.0.1 v0.0.2])
      p.git_remote.expects(:add_tag).with("v0.0.3")
      assert_equal "foo-0.0.3.gem", p.publish_if_updated(:method)
    end

    def test_should_publish_with_options_if_given
      gemspec = data_file_path("example.gemspec")
      p = Publisher.new(gemspec)
      p.builder = mock
      p.builder.stubs(:build).returns("foo-0.0.3.gem")
      p.pusher = mock
      p.pusher.expects(:push).with("foo-0.0.3.gem", :method, :foo => "bar")
      p.git_remote = mock
      p.git_remote.stubs(:tags).returns(%w[v0.0.1 v0.0.2])
      p.git_remote.stubs(:add_tag)
      assert_equal "foo-0.0.3.gem", p.publish_if_updated(:method, :foo => "bar")
    end

    def test_should_build_and_tag_and_publish_and_return_gem_name_if_there_is_no_released_version
      p = Publisher.new(data_file_path("example.gemspec"))
      p.builder = mock
      p.builder.expects(:build).returns("foo-0.0.3.gem")
      p.pusher = mock
      p.pusher.expects(:push)
      p.git_remote = mock
      p.git_remote.stubs(:tags).returns([])
      p.git_remote.expects(:add_tag).with("v0.0.3")
      assert_equal "foo-0.0.3.gem", p.publish_if_updated(:method)
    end

    def test_should_build_and_tag_and_publish_and_return_gem_name_if_the_current_version_has_not_been_released
      p = Publisher.new(data_file_path("example.gemspec"))
      p.builder = mock
      p.builder.expects(:build).returns("foo-0.0.3.gem")
      p.pusher = mock
      p.pusher.expects(:push)
      p.git_remote = mock
      p.git_remote.stubs(:tags).returns(%w[v0.0.1 v0.0.2 v0.1.0])
      p.git_remote.expects(:add_tag).with("v0.0.3")
      assert_equal "foo-0.0.3.gem", p.publish_if_updated(:method)
    end
  end
end
