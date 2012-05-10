lib = File.expand_path("../../lib", __FILE__)
$:.unshift lib unless $:.include?(lib)

require "minitest/autorun"
require "mocha"

class MiniTest::Unit::TestCase
  def data_file(name)
    File.read(File.expand_path("../data/#{name}", __FILE__))
  end
end
