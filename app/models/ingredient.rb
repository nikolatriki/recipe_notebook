class Ingredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :user, optional: true

  validates :substance, presence: true
end
