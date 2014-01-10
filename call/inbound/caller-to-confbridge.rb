#!/usr/bin/ruby1.9.1

require 'plivo'
require 'sinatra'

set :bind, '0.0.0.0'

get '/caller-to-conf' do

  conf_room = "testroom"
  play_loop = 1
  lang = "en-US"
  voice = "WOMAN"
  text = "Welcome to Plivo Cloud. You will be redirected to a Conference Bridge"

  speak_params = {
                  'loop' => play_loop,
                  'language' => lang,
                  'voice' => voice,
                  }

  music_url = "Your Music File Path"    #example, https://s3.amazonaws.com/plivocloud/Trumpet.mp3
  conf_params = {
                  'waitSound' => music_url,
                  }

  plivo = Plivo::Conference.new(conf_room, conf_params)
  speak = Plivo::Speak.new(text, speak_params)
  response = Plivo::Response.new()
  response.add(speak)
  response.add(plivo)
  return response.to_xml
end
