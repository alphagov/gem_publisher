require "shellwords"
require "open3"

module GemPublisher
  class CliFacade
    Error = Class.new(RuntimeError)

    def execute(*arguments)
      cmd = Shellwords.join(arguments)
      stdout_str, stderr_str, status = Open3.capture3(cmd)
      if status.exitstatus > 0
        raise Error, stderr_str
      end
      stdout_str
    end
  end
end
