#!/usr/bin/ruby1.9.1

require 'plivo'
require 'sinatra'
require 'rest_client'

set :bind, '0.0.0.0'

get '/voicemail' do

  play_loop = 1
  lang = "en-US"
  voice = "WOMAN"
  text = "Please leave a message after the beep. Press the star key when done."
  record_param = {
                  'action' => '<Your Action URL>', 		# => http://polar-everglades-1062.herokuapp.com/voicemail
                  'finishOnKey' => '*',
                  'method' => "POST",
		  'transcriptionType' => 'hybrid',
                  'transcriptionUrl' => '<Your Transcription URL>',  # => http://polar-everglades-1062.herokuapp.com/transcript
                  'transcriptionMethod' => 'POST'
                }
  speak_params = {
                  'loop' => play_loop,
                  'language' => lang,
                  'voice' => voice,
                  }
  p = Plivo::Record.new(record_param)
  s = Plivo::Speak.new(text, speak_params)
  r = Plivo::Response.new()
  r.add(s)
  r.add(p)
  return r.to_xml
end

post '/voicemail' do

  $record_url = params[:RecordUrl]
  RestClient.post "https://api:<Your Mailgun Api here>"\
  "@api.mailgun.net/v2/<Your Domain registered @ Mailgun>/messages",
  :from => "Excited User <excited@plivo.com>",
  :to => "test@plivo.com",
  :subject => "Voice Mail Details",
  :text => "Hello, THere is a voice mail for you. Please reach out to the below url for your Voice Mail #{$record_url}"
  return "Thanks for using our service"
end

post '/transcript' do

  @trans_text = params[:transcription_text]
  RestClient.post "https://api:<Your Mailgun Api here>"\
  "@api.mailgun.net/v2/<Your Domain registered @ Mailgun>/messages",
  :from => "Excited User <excited@plivo.com>",
  :to => "test@plivo.com",
  :subject => "Voice Mail Details",
  :text => "#{@trans_text}. plese reach out to the below url for voice mail recording file.#{$record_url}"
  return "Thanks for using our service"
end
