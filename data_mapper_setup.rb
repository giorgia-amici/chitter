env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './models/user'
require './models/peep'

DataMapper.finalize
DataMapper.auto_upgrade!