#!/usr/bin/ruby1.9.1


require 'plivo'
require 'sinatra'

set :bind, '0.0.0.0'

get '/incomingsms.xml' do

  text = "Thank you for sending out SMS"

  msg_params = {
                'text' => text,
                }

  p = Plivo::Message.new(text)

  r = Plivo::Response.new()
  r.add(p)
  return r.to_xml	# this will return the Message XML, which can be used with the Plivo's Message_URL in the APP option.
end
