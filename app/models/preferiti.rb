class Preferiti < ApplicationRecord
	self.table_name = "favourite"
	belongs_to :document
	belongs_to :student
end
