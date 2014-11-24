require 'sinatra'
require 'rack-flash'
require 'data_mapper'
require_relative 'data_mapper_setup'

class Chitter < Sinatra::Base

set :public, Proc.new {File.join(root, "public_folder")}
set :views, Proc.new {File.join(root, "views")}
enable :sessions
set :session_secret, 'super secret'
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
    else
     flash[:errors] = @user.errors.full_messages
      redirect to('/')
    end
  end

  get '/returning_user' do 
    # :username =>  params['username'],
    #                     :email => params['email']
    # raise params
    #  erb :chitter
  end





  def current_user
    @current_user ||=User.get(session[:user_id]) if session[:user_id]
  end


end
