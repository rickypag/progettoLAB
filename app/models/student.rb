class Student < ApplicationRecord
	self.table_name = "student"
	self.primary_key = "username"
	
	validates :name, presence: true
	validates :surname, presence: true
	validates :username, presence: true, uniqueness: true
	
end