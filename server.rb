require 'sinatra/base'
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

  get '/' do
    @user = User.new
  	erb :index
  end

  post '/users' do
  	@user = User.create(name: params['name'], 
                        :username => params['username'],
                        :email => params['email'], 
                        :password => params['password'])
  	erb :index

  end

end
