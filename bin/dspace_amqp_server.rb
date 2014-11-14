#!/usr/bin/env ruby -rubygems
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib')))
require 'dspace_amqp_server'

#only run if given run as the first argument. This is useful for letting us load this file in irb to work with things interactively when we need to
DspaceAmqpServer::Server.new(config_file: '../config/dspace_amqp_server.yml').run if ARGV[0] == 'run'