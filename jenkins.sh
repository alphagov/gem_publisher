#!/bin/sh
set +e
rm -f Gemfile.lock
bundle install --path "${HOME}/bundles/${JOB_NAME}"
bundle exec rake test
bundle exec rake publish_gem
