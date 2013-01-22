require 'rubygems'
require 'bundler'

require File.expand_path(File.join(File.dirname(__FILE__), 'application'))

Bundler.require(:app)

run Audio.new