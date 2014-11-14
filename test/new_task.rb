#!/usr/bin/env ruby
# encoding: utf-8

require 'bunny'
require 'json'

conn = Bunny.new
conn.start

ch   = conn.create_channel
q    = ch.queue("va_to_ideals", :durable => true)

bag_url = "https://raw.githubusercontent.com/UIUCLibrary/dspace_amqp_server/master/test/Vortex2Visualization.zip"

msg  = {"action" => "ideals_deposit", "parameters" => {"message_name" => "bag-stage-location", "correlation_id" => "d6d250ba-e54d-4ae0-937d-c23d5e8b5de8", "protocol" => "http", "location" => "#{bag_url}"}}.to_json

q.publish(msg, :persistent => true)
puts " [x] Sent #{msg}"

sleep 1.0
conn.close