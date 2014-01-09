#!/usr/bin/ruby1.9.1

require 'plivo'
require 'sinatra'

set :bind, '0.0.0.0'

get '/message' do

  play_loop = 1
  lang = "en-US"
  voice = "WOMAN"
  text = "Congratulations! You just made a text to speech app on Plivo cloud!"

  speak_params = {
                  'loop' => play_loop,
                  'language' => lang,
                  'voice' => voice,
                  }

  p = Plivo::Speak.new(text, speak_params)

  r = Plivo::Response.new()
  r.add(p)
  return r.to_xml
end
