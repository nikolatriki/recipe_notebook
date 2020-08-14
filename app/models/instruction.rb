class Instruction < ApplicationRecord
  belongs_to :recipe
  belongs_to :user, optional: true

  validates :step, presence: true
end
