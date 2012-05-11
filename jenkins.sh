#!/bin/sh
set +e
rake test
rake publish_gem
