class Cronologium < ApplicationRecord
  belongs_to :document
  belongs_to :student
end
