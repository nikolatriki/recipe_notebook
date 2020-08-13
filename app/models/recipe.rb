class Recipe < ApplicationRecord
  MINIMUM_TITLE_LENGTH = 4
  MAXIMUM_TITLE_LENGTH = 40

  has_many :ingredients, dependent: :destroy
  has_many :instructions, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :ingredients,
                                allow_destroy: true,
                                reject_if: lambda { |attributes| attributes[:substance].blank? }

  accepts_nested_attributes_for :instructions,
                                allow_destroy: true,
                                reject_if: lambda {|attributes| attributes[:step].blank?}

  validates :title, presence: true, length: { minimum: MINIMUM_TITLE_LENGTH,
                                              maximum: MAXIMUM_TITLE_LENGTH,
                                            }
  validates :description, presence: true
end
