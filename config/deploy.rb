require 'bundler/capistrano'
require 'capistrano/ext/multistage'

set :stages, ["staging", "production"]
set :default_stage, "staging"
