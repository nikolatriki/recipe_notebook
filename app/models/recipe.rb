class Recipe < ApplicationRecord
  MINIMUM_TITLE_LENGTH = 4
  validates :title, presence: true, length: { minimum: MINIMUM_TITLE_LENGTH }
  validates :description, presence: true
end
