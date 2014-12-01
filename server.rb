env = ENV["RACK_ENV"] || "development"


require 'data_mapper'
require 'sinatra'
require 'rack-flash'
require 'sinatra/partial'
require_relative 'data_mapper_setup'
require_relative 'helpers/application'

require './models/user'
require './models/peep'
DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")


DataMapper.finalize
DataMapper.auto_upgrade!
class Chitter < Sinatra::Base

set :public_folder, Proc.new {File.join(root, "public_folder")}
set :views, Proc.new {File.join(root, "views")}
enable :sessions
set :session_secret, 'super secret'
use Rack::Flash
use Rack::MethodOverride
set :partial_template_engine, :erb



  get '/' do
    @user = User.new
    erb :index
  end

  post '/user/new' do
    @user = User.new(:name => params['name'], 
                        :username =>  params['username'],
                        :email => params['email_su'], 
                        :password =>  params['password_su'],
                        :password_confirmation =>  params['password_confirmation'])
    if @user.save
      session[:user_id] = @user_id
      erb :chitter
    else
     flash[:errors] = @user.errors.full_messages
      redirect to('/')
    end
  end

  post '/session/new' do 
    email, password = params['email_si'], params['password_si']
    @user = User.authenticate(email, password)
    if @user
      session[:user_id] = @user.id
      erb :chitter
    else
      flash[:errors] = ["The email or password is incorrect"]
      redirect to('/')
    end
  end

  get '/peep' do 
    erb :posts
  end

  post '/peep/new' do
    @peep = Peep.create(:content => params['peep'],
                          :user_id => session[:user_id])
    @peeps = Peep.all(:order => [ :id.desc ], :limit => 20)
    erb :posts
  end

  post '/' do 
    unless session[:user_id] == nil
      @user_id = nil
      session[:user_id] = nil
      flash[:notice] = "You have signed out - Bye!"     
    end
    redirect to ('/')
  end

  get '/user/forgot_password' do 
    erb :forgot_password
  end

  post '/forgot_password' do 
    @user = User.first(:email => params["email"])
    @user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
    @user.save
    redirect to ('/reset_password/:token')
  end

  get '/reset_password/:token' do 
    @token = params[:token]
    @user = User.first[password_token: @token]
    erb :new_password
  end

  post '/user/reset_password' do 
    @user = User.first(password_token: @token)
    @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
    "Your password has been updated"
  end


  def send_simple_message
    RestClient.post "https://api:key-3ax6xnjp29jd6fds4gc373sgvjxteol0"\
    "@api.mailgun.net/v2/samples.mailgun.org/messages",
    :from => "Excited User <me@samples.mailgun.org>",
    :to => "bar@example.com, baz@example.com",
    :subject => "Hello",
    :text => "Testing some Mailgun awesomness!"
  end



end
