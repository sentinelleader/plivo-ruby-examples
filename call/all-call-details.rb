#!/usr/bin/ruby1.9.1

require 'plivo'


PLIVO_AUTH_ID = "XXXXXXXXXXXXXXXXXXXXXX"
PLIVO_AUTH_TOKEN = "XXXXXXXXXXXXXXXXXXX"

p = Plivo::RestAPI.new(PLIVO_AUTH_ID, PLIVO_AUTH_TOKEN)

outbound_detail = {
		   'call_direction' => 'outbound'
		  }

inbound_detail = {
		   'call_direction' => 'inbound'
		 }
puts "Outbound Call Details"

details =  p.get_cdrs(outbound_detail)
all_calls = details[1]
puts all_calls["objects"]

puts "Inbound Call Details"

details =  p.get_cdrs(inbound_detail)
all_calls = details[1]
puts all_calls["objects"]
