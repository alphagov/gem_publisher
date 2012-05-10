require "gem_publisher/cli_facade"

module GemPublisher
  class Pusher
    def initialize(cli_facade = CliFacade.new)
      @cli_facade = cli_facade
    end

    PUSH_METHODS = {
      :rubygems => %w[gem push],
      :gemfury  => %w[fury push]
    }

    def push(gem, method)
      push_command = PUSH_METHODS[method] or raise "Unknown Gem push method #{method.inspect}."
      @cli_facade.execute *push_command + [gem]
    end
  end
end

