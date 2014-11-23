require 'sinatra'
require 'rack-flash'
require 'data_mapper'


env = ENV['RACK_ENV'] || "development" 
DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './models/user'
require './models/peep'

DataMapper.finalize
DataMapper.auto_upgrade!

class Chitter < Sinatra::Base

set :public, Proc.new {File.join(root, "public_folder")}
set :views, Proc.new {File.join(root, "views")}
enable :sessions
use Rack::Flash

  get '/' do
    @user = User.new
  	erb :index
  end

  post '/user/new' do
  	@user = User.new(:name => params['name'], 
                        :username =>  params['username'],
                        :email => params['email'], 
                        :password =>  params['password'],
                        :password_confirmation =>  params['password_confirmation'])
  	if @user.save
      session[:user_id] = @user_id
      erb :chitter
      # redirect to '/user_profile'
    else
     flash[:notice] = "Sorry, your passwords don't match"
      redirect to('/')
    end
  end

  get '/returning_user' do 
    # :username =>  params['username'],
    #                     :email => params['email']
    raise params
     erb :chitter
  end



end
