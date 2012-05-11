Gem Publisher
=============

This library will assist you in automatically publishing gems to a variety of
repositories.

At present, *variety* means RubyGems.org or GemFury.

How it works
------------

* Checks whether the remote version tag (of the form `vX.Y.Z`) for the last
  released version is older than the current revision
* Builds a gem for the updated version
* Remotely tags the new version
* Pushes the gem to the gem server

Example
-------

In your `Rakefile`:

    require "your_gem/version"
    require "gem_publisher"

    task :publish_gem do |t|
      GemPublisher.publish_if_updated "yourgem.gemspec", YourGem::VERSION, :rubygems
    end

You can now add `rake publish_gem` to your continuous integration server as a
task to run after the tests pass.
