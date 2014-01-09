#!/usr/bin/ruby1.9.1


require 'plivo'
require 'sinatra'

set :bind, '0.0.0.0'

get '/incomingsms.xml' do

  text = params[:text]
 
  if text == 1
    puts "option 1"
  elsif text == 2
    puts "option2"
  elsif text == 3
    puts "option3"
  else
    text = "Welcome to Plivo! For Current Temp reply 1, For Current National Debt reply 2, For Joke reply 3"

    msg_params = {
                  'text' => text,
                  }

    p = Plivo::Message.new(text)

    r = Plivo::Response.new()
    r.add(p)
    return r.to_xml	# this will return the Message XML, which can be used with the Plivo's Message_URL in the APP option.
  end
end
