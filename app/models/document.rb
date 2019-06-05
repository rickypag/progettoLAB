class Document < ApplicationRecord
	self.table_name = "document"
	self.primary_key = "uuid"
	has_many :likes, dependent: :destroy
	
	validates :title, presence: true
	
end
