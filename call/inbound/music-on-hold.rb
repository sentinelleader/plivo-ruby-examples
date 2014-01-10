#!/usr/bin/ruby1.9.1

require 'plivo'
require 'sinatra'

set :bind, '0.0.0.0'

get '/music-on-hold' do

  music_url = "Your Music File Path"    #example, https://s3.amazonaws.com/plivocloud/Trumpet.mp3
  conf_params = {
                  'waitSound' => music_url,
                  }
  conf_room = "testroom"

  p = Plivo::Conference.new(conf_room, conf_params)

  response = Plivo::Response.new()
  response.add(p)
  return response.to_xml
end
