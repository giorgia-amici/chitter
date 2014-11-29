module SessionHelpers
	
	def sign_up(name = "giorgia", username = "gio", email = "gio@gio", password = "yoyo", password_confirmation = 'yoyo')
		fill_in 'name', :with => name
		fill_in 'username', :with => username
		fill_in 'email_su', :with => email
		fill_in 'password_su', :with => password
		fill_in 'password_confirmation', :with => password_confirmation
		click_on "Sign Up"
	end

def sign_in(email, password)
		fill_in 'email_si', :with => email
		fill_in 'password_si', :with => password
		click_on "Sign In"
end

def sign_out
	click_on "Sign Out"
end
