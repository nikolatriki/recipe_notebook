class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :substance, presence: true
end
