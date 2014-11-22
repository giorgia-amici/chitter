require 'sinatra/base'
require 'data_mapper'

env = ENV['RACK_ENV'] || "development" 
DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")



class Chitter < Sinatra::Base

set :public, Proc.new {File.join(root, "public")}
set :views, Proc.new {File.join(root, "views")}

  get '/' do
  	erb :index
  end

  post '/active_session' do

  end

end
