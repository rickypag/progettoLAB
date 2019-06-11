class Student < ApplicationRecord
	self.table_name = "student"
	self.primary_key = "username"
	has_many :likes, dependent: :destroy
	has_many :preferiti, dependent: :destroy
	has_many :report, dependent: :destroy
	has_many :cronologium, dependent: :destroy
	
	validates :name, presence: true, length: { maximum: 10 }
	validates :surname, presence: true, length: { maximum: 10 }
	VALID_USERNAME_REGEX = /\A[a-z]+[a-z\d\_]+\z/i
	validates :username, presence: true, uniqueness: true, 
						length: { maximum: 10 }, 
						format: { with: VALID_USERNAME_REGEX }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
			format: { with: VALID_EMAIL_REGEX }, uniqueness: true
	
end
