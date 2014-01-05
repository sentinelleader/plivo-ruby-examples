#!/usr/bin/ruby1.9.1

require 'plivo'
require 'json'

PLIVO_AUTH_ID = "XXXXXXXXXXXXXXXXXXXX"
PLIVO_AUTH_TOKEN = "XXXXXXXXXXXXXXXXXX"

plivo_number = "XXXXXXXXXXXXXXXXX"

record_id = "XXXXXXXXXXXXXXXXXXXXXX"


message_params = {
      		'record_id' => record_id,
    		}

p = Plivo::RestAPI.new(PLIVO_AUTH_ID, PLIVO_AUTH_TOKEN)
resp = (p.get_message(message_params))

msg_details = JSON.parse((resp[1]).to_json)

from_number = msg_details["from_number"]

to_number = msg_details["to_number"]

sent_time = msg_details["message_time"]

msg_direction = msg_details["message_direction"]

if msg_direction == 'outbound'
  puts "Message Seems to be Outbound. Sent from Plivo Number #{plivo_number} to #{to_number} @ #{sent_time}"
else
  text = "Reply message"
  message_params = {
                'src' => plivo_number,
                'dst' => from_number,
                'text' => text,
                }  
  p = Plivo::RestAPI.new(PLIVO_AUTH_ID, PLIVO_AUTH_TOKEN)
  puts "Successfully replied back to the SMS received from #{from_number}"
  puts p.send_message(message_params)
end
