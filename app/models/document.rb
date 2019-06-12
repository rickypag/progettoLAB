class Document < ApplicationRecord
	self.primary_key = "document_id"
	has_many :likes, dependent: :destroy
	has_many :preferiti, dependent: :destroy
	has_many :report, dependent: :destroy
	has_many :cronologium, dependent: :destroy
	
	validates :title, presence: true
	
end
