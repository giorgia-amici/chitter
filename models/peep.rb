require 'dm-timestamps'

class Peep

	include DataMapper::Resource

	property :id,          Serial
	property :content,     Text
	property :created_at,  DateTime

	has n  :users, :through => Resource      

end