#!/usr/bin/ruby1.9.1

require 'plivo'
require 'sinatra'

set :bind, '0.0.0.0'

get '/ivr' do

    text = "Welcome to IVR Menu. Press 1 to call User1. Press 2 to call User2 "
    text_end = "Input not received. Thank you"
    play_loop = 1
    lang = "en-US"
    voice = "WOMAN"
    digit_params = {
                  'action' => 'http://www.example.com/gather/',
                  'method' => 'POST',
                  'timeout' => '7',
                  'numDigits' => '1',
                  'playBeep' => 'true'
                 }
    speak_params = {
                  'loop' => play_loop,
                  'language' => lang,
                  'voice' => voice,
                  }
    get_digits = Plivo::GetDigits.new(digit_params)
    speak = Plivo::Speak.new(text, speak_params)
    get_digits.add(speak)
    response = Plivo::Response.new()
    response.add(speak)
    speak_end = Plivo::Speak.new(text_end, speak_params)
    response.add(speak_end)
    return response.to_xml
end

post '/ivr' do
    
    user1 = 'XXXXXXXXXXX'
    user2 = 'XXXXXXXXXXX'

    digits = params[:Digits]
    
    if digits == '1'
  
        play_loop = 1
  	lang = "en-US"
  	voice = "WOMAN"
  	text = "Dialling User1"

  	speak_params = {
  	                'loop' => play_loop,
  	                'language' => lang,
  	                'voice' => voice,
  	                }
	speak = Plivo::Speak.new(text, speak_params) 
 	num_add = Plivo::Number.new(user1)
        dial = Plivo::Dial.new()
        dial.add(num_add)
        response = Plivo::Response.new()
	response.add(speak)
        response.add(dial)
	return response.to_xml

     elsif digits == '2'
	play_loop = 1
        lang = "en-US"
        voice = "WOMAN"
        text = "Dialling User2"

        speak_params = {
                        'loop' => play_loop,
                        'language' => lang,
                        'voice' => voice,
                        }
        speak = Plivo::Speak.new(text, speak_params)
        num_add = Plivo::Number.new(user2)
        dial = Plivo::Dial.new()
        dial.add(num_add)
        response = Plivo::Response.new()
        response.add(speak)
        response.add(dial)
        return response.to_xml

     else
	text = "Invalid Option Selected, Please Hangup and try again"
	play_loop = 1
        lang = "en-US"
        voice = "WOMAN"

        speak_params = {
                        'loop' => play_loop,
                        'language' => lang,
                        'voice' => voice,
                        }
        speak = Plivo::Speak.new(text, speak_params)
	response = Plivo::Response.new()
        response.add(speak)
	return response.to_xml	
    end
end
