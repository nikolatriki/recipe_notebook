class Recipe < ApplicationRecord
  MINIMUM_TITLE_LENGTH = 4

  has_many :ingredients
  has_many :instructions
  validates :title, presence: true, length: { minimum: MINIMUM_TITLE_LENGTH }
  validates :description, presence: true
end
