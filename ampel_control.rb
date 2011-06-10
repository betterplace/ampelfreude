#!/usr/bin/env ruby
require 'rubygems'        # if you use RubyGems
require 'daemons'

Daemons.run(File.expand_path(File.dirname(__FILE__)) + '/ampel_runner.rb')