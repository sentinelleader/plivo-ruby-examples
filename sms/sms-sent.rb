#!/usr/bin/ruby1.9.1

require 'plivo'

PLIVO_AUTH_ID = "XXXXXXXXXXXXXXXXXXXXX"
PLIVO_AUTH_TOKEN = "XXXXXXXXXXXXXXXXXXXXXXXXXX"

plivo_number = "XXXXXXXXXXXXX"

destination_number = "XXXXXXXXXXXXXXX"

text = "Welcome to Plivo!"

message_params = {
      		'src' => plivo_number,
      		'dst' => destination_number,
      		'text' => text,
    		}

p = Plivo::RestAPI.new(PLIVO_AUTH_ID, PLIVO_AUTH_TOKEN)
puts p.send_message(message_params)
