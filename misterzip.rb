require 'sinatra/base'
require 'json'
require 'pony'

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
end

class MisterZip < Sinatra::Base

  configure do
    set :app_file, __FILE__
    set :port, ENV['PORT']
  end

  helpers do
    def error(reason, code=400)
      status code
      { error: code, reason: reason }.to_json
    end

    def success(resource, code=200)
      status code
      resource.to_json
    end
  end

  NAMESPACE = '/misterzip';

  before do
    content_type :json
  end

  post "#{NAMESPACE}/letter" do
    entity = JSON.parse request.body.read
    letter = Letter.new(entity)
    recipient = ENV['MISTERZIP_RECIPIENT']
    raise "please set the MISTERZIP_RECIPIENT environment variable" if recipient.nil?
    if letter.deliver_to 'tom@crystae.net'
      success entity, 201
    else
      message = letter.errors.full_messages().join ", "
      error message
    end
  end

  run! if app_file == $0
end

