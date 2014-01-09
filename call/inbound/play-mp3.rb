#!/usr/bin/ruby1.9.1

require 'plivo'
require 'sinatra'

set :bind, '0.0.0.0'

get '/music' do


  music_url = "Your Music File Path"    #example, https://s3.amazonaws.com/plivocloud/Trumpet.mp3

  p = Plivo::Play.new(music_url)

  r = Plivo::Response.new()
  r.add(p)
  return r.to_xml
end
