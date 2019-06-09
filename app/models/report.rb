class Report < ApplicationRecord
  belongs_to :document
  belongs_to :student
end
