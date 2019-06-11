class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
		   :recoverable, :rememberable, :validatable,
		   :omniauthable, :omniauth_providers => [:facebook]
	
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
			format: { with: VALID_EMAIL_REGEX }, uniqueness: true
	
	#has_secure_password   #???password_digest???
	validates :password, length: { minimum: 6 }
	
	enum role: [:student, :moderatore]
	after_initialize :set_default_role, :if => :new_record?
	
	def set_default_role
		self.role ||= :student
	end
	        
	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.email = auth.info.email
			user.password = Devise.friendly_token[0,20]
		end
	end
	
	def self.new_with_session(params, session)
		super.tap do |user|
			if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
				user.email = data["email"] if user.email.blank?
			end
		end  
	end
end
