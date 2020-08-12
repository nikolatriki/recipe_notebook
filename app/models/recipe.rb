class Recipe < ApplicationRecord
  MINIMUM_TITLE_LENGTH = 4
  MAXIMUM_TITLE_LENGTH = 40

  has_many :ingredients, dependent: :destroy
  has_many :instructions, dependent: :destroy

  accepts_nested_attributes_for :ingredients,
                                allow_destroy: true,
                                reject_if: lambda {|attributes| attributes[:substance].blank?}

  accepts_nested_attributes_for :instructions,
                                allow_destroy: true,
                                reject_if: lambda {|attributes| attributes[:step].blank?}

  validates :title, presence: true, length: { minimum: MINIMUM_TITLE_LENGTH,
                                              maximum: MAXIMUM_TITLE_LENGTH,
                                              ingredients_attributes: [:id, :substance, :_destroy],
                                              instructions_attributes: [:id, :step, :_destroy]
                                             }
  validates :description, presence: true
end
