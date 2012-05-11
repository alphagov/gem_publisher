Gem Publisher
=============

This library will assist you in automatically publishing gems to a variety of
repositories.

At present, *variety* means RubyGems.org or GemFury.

Requires Ruby 1.9.

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

    require "gem_publisher"

    task :publish_gem do |t|
      gem = GemPublisher.publish_if_updated("yourgem.gemspec", :rubygems)
      puts "Published #{gem}" if gem
    end

Use `:gemfury` instead of `:rubygems` if you want to publish to GemFury instead.

This assumes that the requisite credentials have been set up so that the
`gem push` and `fury push` commands work.

You can now add `rake publish_gem` to your continuous integration server as a
task to run after the tests pass.
