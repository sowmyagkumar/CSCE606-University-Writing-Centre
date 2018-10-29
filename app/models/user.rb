class User < ApplicationRecord
	has_many :tasks , :dependent=> :destroy, :autosave => true
	before_save :encrypt_password, :send_email
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

	def send_email
		self.confirm_code = BCrypt::Engine.hash_secret(self.email,self.salt)
		ConfMailer.send_conf_email(self).deliver_now
	end

	def set_confirm
		self.update_column(:confirm, true)
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
