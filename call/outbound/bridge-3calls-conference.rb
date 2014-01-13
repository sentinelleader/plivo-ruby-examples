#!/usr/bin/ruby1.9.1

require 'plivo'
require 'sinatra'

set :bind, '0.0.0.0'

get '/bridgecall' do

  text = "Hello, you will be redireted to an automated conference call"
  music_url = "Your Music File Path"    #example, https://s3.amazonaws.com/plivocloud/Trumpet.mp3
  conf_params = {
                  'waitSound' => music_url,
		  'startConferenceOnEnter' => 'true',
		  'endConferenceOnExit' => 'true'
                  }
   play_loop = 1
   lang = "en-US"
   voice = "WOMAN"
   text = "Congratulations! You just made a text to speech app on Plivo cloud!"

   speak_params = {
                   'loop' => play_loop,
                   'language' => lang,
                   'voice' => voice,
                   }
  conf_room = "testroom"

   record_param = {
                  'action' => 'Your Action URL',              # => http://polar-everglades-1062.herokuapp.com/voicemail
		  'startOnDialAnswer' => 'true',
                  'method' => "POST",
                }
  record = Plivo::Record.new(record_param)
  speak = Plivo::Speak.new(text, speak_params)
  plivo = Plivo::Conference.new(conf_room, conf_params)

  response = Plivo::Response.new()
  response.add(record)
  response.add(speak)
  response.add(plivo)
  return response.to_xml
end
