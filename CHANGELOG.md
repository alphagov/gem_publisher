## 1.4.0

* Add a `tag_prefix` option to support tag conventions other than `v1.4.0`

## 1.3.2

* Pin Mocha development dependency to fix test failures
* Include `stdout` in error messages

## 1.3.1

* Fix a scoping bug when determining a gem's version

## 1.3.0

* Make the `version_released?` method public, to support more complex workflows

## 1.2.0

* Support publishing to Gemfury, including the `--as` option
* Add a description, so the `publish_gem` task shows up in `rake -T`

## 1.1.1

* Fix a bug where `gem_publisher` would try to re-release a published version
  if a later version was also published

## 1.1.0

* Fix some early bugs, improve documentation and add a RubyGems command plugin

## 1.0.0

* First supported release
