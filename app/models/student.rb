class Student < ApplicationRecord
	self.table_name = "student"
	self.primary_key = "username"
	has_many :likes, dependent: :destroy
	has_many :preferiti, dependent: :destroy
	has_many :report, dependent: :destroy
	
	validates :name, presence: true
	validates :surname, presence: true
	validates :username, presence: true, uniqueness: true
	
end
