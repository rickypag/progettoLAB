class Student < ApplicationRecord
	self.table_name = "student"
	self.primary_key = "username"
<<<<<<< HEAD
	has_many :likes, dependent: :destroy
	has_many :preferiti, dependent: :destroy
	has_many :report, dependent: :destroy
=======
>>>>>>> c63412f323eb3b6124db28c340a232abef7923b1
	
	validates :name, presence: true
	validates :surname, presence: true
	validates :username, presence: true, uniqueness: true
	
end
