class Ingredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :user, optional: true
  # optional: true is for escaping error 'Instruction recipe doesn't exist' when user creates recipe

  validates :substance, presence: true
end
