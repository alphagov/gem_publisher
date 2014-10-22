require File.expand_path("../common", __FILE__)
require "rubygems_plugin"
require "rubygems/test_case"

module GemPublisher
  class PublishCommandTest < Gem::TestCase
    def setup
      super
      @command = Gem::Commands::PublishCommand.new
    end

    def test_should_report_published_gem
      GemPublisher.expects(:publish_if_updated)
                  .with("awesome.gemspec", "rubygems")
                  .returns("awesome-1.0.0.gem")
      $stderr.expects(:puts).with("Published awesome-1.0.0.gem")

      @command.handle_options ["awesome.gemspec"]
      @command.execute
    end

    def test_should_not_report_unpublished_gem
      GemPublisher.expects(:publish_if_updated)
                  .with("awesome.gemspec", "rubygems")
                  .returns(nil)
      $stderr.expects(:puts).with("Nothing to do for awesome.gemspec")

      @command.handle_options ["awesome.gemspec"]
      @command.execute
    end

    def test_should_use_gemfury_if_requested
      GemPublisher.expects(:publish_if_updated)
                  .with("awesome.gemspec", "gemfury")
                  .returns("awesome-1.0.0.gem")
      $stderr.expects(:puts).with(anything)

      @command.handle_options ["-r", "gemfury", "awesome.gemspec"]
      @command.execute
    end

    def test_should_use_gemfury_with_long_option
      GemPublisher.expects(:publish_if_updated)
                  .with("awesome.gemspec", "gemfury")
                  .returns("awesome-1.0.0.gem")
      $stderr.expects(:puts).with(anything)

      @command.handle_options ["--repository=gemfury", "awesome.gemspec"]
      @command.execute
    end
  end
end
