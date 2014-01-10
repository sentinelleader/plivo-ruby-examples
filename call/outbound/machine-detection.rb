#!/usr/bin/ruby1.9.1

require 'plivo'
require 'sinatra'

set :bind, '0.0.0.0'

post '/machinedetect' do

  machine = params[:Machine]
  if machine == "True"
    text = "Answering Machine detected"
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
  else
    text = "Welcome to IVR. Please Press 1 to connect to User1, Press 2 to connect to User2"
    text2 = "Input not received. Thank you"
    digit_params = {
		  'action' => 'http://www.example.com/gather/',
		  'method' => 'POST',
		  'timeout' => '7',
		  'numDigits' => '1',
		  'playBeep' => 'true'
		 }
    play_loop = 1
    lang = "en-US"
    voice = "WOMAN"
    speak_params = {
                  'loop' => play_loop,
                  'language' => lang,
                  'voice' => voice,
                  }
    get_digits = Plivo::GetDigits.new(digit_params)
    txt = Plivo::Speak.new(text, speak_params)
    get_digits.add(txt)
    response = Plivo::Response.new()
    response.add(get_digits)
    txt2 = Plivo::Speak.new(text2, speak_params)
    response.add(txt2)
    return response.to_xml
  end
end
