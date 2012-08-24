# Gem Publisher

This library will assist you in automatically publishing gems to a variety of
repositories.

At present, *variety* means RubyGems.org or GemFury.

Requires Ruby 1.9.

## How it works

It first checks whether a version tag (of the form `vX.Y.Z`) for the current
version exists in the remote repository.  If the tag does not exist, it does the following:

* Builds a gem for the updated version
* Remotely tags the new version
* Pushes the gem to the gem server

## Limitations

* Only git repositories are supported
* The remote repository must be called `origin`

## Example

### Via rake

In your `Rakefile`:

    require "gem_publisher"

    desc "Publish gem to RubyGems.org"
    task :publish_gem do |t|
      gem = GemPublisher.publish_if_updated("yourgem.gemspec", :rubygems)
      puts "Published #{gem}" if gem
    end

Use `:gemfury` instead of `:rubygems` if you want to publish to GemFury instead.

You'll probably need to add `gem_publisher` as a development dependency in
order to satisfy Bundler. In `{name of gem}.gemspec`, add the dependency:

    s.add_development_dependency "gem_publisher", "~> 1.1.1"

If you're using GemFury, add that too:

    s.add_development_dependency "gemfury"

You can now add `rake publish_gem` to your continuous integration server as a
task to run after the tests pass.

This assumes that the requisite credentials have been set up so that the
`gem push` and `fury push` commands work.

### Via command line

This method obviates the need to add extra development dependencies to your
project.

    gem publish yourgem.gemspec

(rubygems is the default repository) or

    gem publish -r gemfury yourgem.gemspec

As before, `gem push` or `fury push` must be available and configured.
