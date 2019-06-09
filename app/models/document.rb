class Document < ApplicationRecord
	self.table_name = "document"
	self.primary_key = "uuid"
	has_many :likes, dependent: :destroy
	has_many :preferiti, dependent: :destroy
	has_many :report, dependent: :destroy
	
	validates :title, presence: true
	
end
