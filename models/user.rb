class User

	require 'bcrypt'
	include DataMapper::Resource

	property :id,                  Serial         
	property :name,                String
	property :username,            String
	property :email,    	         String, :unique => true, :message => "This email is already taken"
	property :password_digest,     Text


	has n, :peeps, :through => Resource


	# attr_reader :password
	# attr_accessor :password_digest

	# validates_confirmation_of :password, :message => "Sorry, your passwords don't match"


#chitters

end