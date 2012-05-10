require File.expand_path("../common", __FILE__)
require "gem_publisher"

module GemPublisher
  class IntegrationTest < MiniTest::Unit::TestCase
    def setup
      Open3.stubs(:capture3)
    end

    def expect_cli(command, response = "")
      Open3.expects(:capture3).
        with(command).
        returns([response, "", stub(exitstatus: 0)])
    end

    def test_should_build_and_tag_and_publish
      expect_cli "git ls-remote --tags origin", data_file("tags")
      expect_cli "gem build example.gemspec", data_file("gem_build")
      expect_cli "gem push test_gem-0.0.2.gem"
      expect_cli "git rev-parse HEAD", "1234abcd"
      expect_cli "git update-ref refs/tags/v1.0.0 1234abcd"
      expect_cli "git push origin tag v1.0.0"
      GemPublisher.publish_if_updated "example.gemspec", "1.0.0"
    end
  end
end
