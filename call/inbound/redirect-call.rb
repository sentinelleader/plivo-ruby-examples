#!/usr/bin/ruby1.9.1

require 'plivo'
require 'sinatra'

set :bind, '0.0.0.0'

get '/redirect' do

  play_loop = 1
  lang = "en-US"
  voice = "WOMAN"
  text = "Please wait while you call is being transferred"

  speak_params = {
                  'loop' => play_loop,
                  'language' => lang,
                  'voice' => voice,
                  }

  redirect_url = "< Your Redirect URL >"  		# => http://polar-everglades-1062.herokuapp.com/redirect-call
  p = Plivo::Speak.new(text, speak_params)
  redirect = Plivo::Redirect.new(redirect_url)
  r = Plivo::Response.new()
  r.add(p)
  r.add(redirect)
  return r.to_xml
end

get '/redirect-call' do

  user = "sip id of the Outbound user"			# => sip:deepakmdass88140105125432@phone.plivo.com
  text = "Please Wait while we Connect to the User"
  play_loop = 1
  lang = "en-US"
  voice = "WOMAN"
  speak_params = {
                  'loop' => play_loop,
                  'language' => lang,
                  'voice' => voice,
                  }


  p = Plivo::Speak.new(text, speak_params)
  user_add = Plivo::User.new(user)
  dial = Plivo::Dial.new()
  response = Plivo::Response.new()
  response.add(p)
  dial.add(user_add)
  response.add(dial)
  return response.to_xml
end
