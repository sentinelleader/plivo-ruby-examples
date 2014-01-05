#!/usr/bin/ruby1.9.1

require 'plivo'
require 'json'

debug = 'false'
inbound_count = 0
outbound_count = 0
inbound_msgs = Hash.new
outbound_msgs = Hash.new

PLIVO_AUTH_ID = "XXXXXXXXXXXXXXXXXXXXXXXXX"
PLIVO_AUTH_TOKEN = "XXXXXXXXXXXXXXXXXXXXXXXX"


p = Plivo::RestAPI.new(PLIVO_AUTH_ID, PLIVO_AUTH_TOKEN)
msg_details =  p.get_messages()

msg_json =  (msg_details[1])

if debug != 'true'

  msg_json["objects"].each do |msgs|
	if msgs["message_direction"] == "inbound"
	  inbound_count += 1
	end
	if msgs["message_direction"] == "outbound"
	  outbound_count +=1
	end
  end
  puts "Inbound Messages -> #{inbound_count} Messages"
  puts "Outbound Messages -> #{outbound_count} Messages"
elsif debug == 'true'
  msg_json["objects"].each do |msgs|
	if msgs["message_direction"] == "inbound"
	  inbound_count += 1
	  inbound_msgs["#{inbound_count}"] = msgs
	end
	if msgs["message_direction"] == "outbound"
	  outbound_count += 1
	  outbound_msgs["#{outbound_count}"] = msgs
	end
  end
  puts "<------- Inbound Messages Details ------->"
  puts inbound_msgs
  puts "<------- Outbound Messages Details ------->"
  puts outbound_msgs
else

  puts"wrong debug option mentioned"
end
puts inbound_msgs

