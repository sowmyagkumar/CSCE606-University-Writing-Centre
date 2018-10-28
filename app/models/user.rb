class User < ApplicationRecord
	has_many :tasks , :dependent=> :destroy, :autosave => true
	before_save :encrypt_password
	EMAIL_REGEX = /\A.+@.+\Z/i
	validates :email, :uniqueness => true, :format => EMAIL_REGEX
	validates :password, :confirmation => true #password_confirmation attr
	validates_length_of :password, :in => 6..20, :on => :create

	def encrypt_password
	  if password.present?
	    self.salt = BCrypt::Engine.generate_salt
	    self.password= BCrypt::Engine.hash_secret(password, salt)
	  end
	end

	def self.authenticate(email="", login_password="")
	    user = User.find_by(email: email)
			match = (user.password == BCrypt::Engine.hash_secret(login_password, user.salt))
	  if user && match
	    return user
	  else
	    return false
	  end
	end
end
