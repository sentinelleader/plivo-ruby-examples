#!/usr/bin/ruby1.9.1

require 'plivo'


PLIVO_AUTH_ID = "XXXXXXXXXXXXXXXXXXXXX"
PLIVO_AUTH_TOKEN = "XXXXXXXXXXXXXXXXXX"

plivo_number = "XXXXXXXXXXXXX"		# example, 19104204390
to_number = "XXXXXXXXXXXXXXXX"
answer_url = "Your Heroku App URL"	# example, http://example.herokuapp.com/answer

call_params = {
                'from' => plivo_number,
                'to' => to_number,
                'answer_url' => answer_url,
		'answer_method' => 'GET'
                }

p = Plivo::RestAPI.new(PLIVO_AUTH_ID, PLIVO_AUTH_TOKEN)

puts p.make_call(call_params)
