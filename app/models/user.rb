class User < ApplicationRecord
  MAXIMUM_HANDLE_LENGTH = 20
  MAXIMUM_FIRST_NAME_LENGTH = 20
  MAXIMUM_LAST_NAME_LENGTH = 20
  MAXIMUM_EMAIL_LENGTH = 25
  MINIMUM_PASSWORD_LENGTH = 6
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  before_save :email_to_downcase

  has_many :recipes, dependent: :destroy
  has_many :instructions, dependent: :destroy
  has_many :ingredients, dependent: :destroy

  has_secure_password

  validates :handle, presence: true, length: { maximum: MAXIMUM_HANDLE_LENGTH },
                     uniqueness: true
  validates :first_name, presence: true, length: { maximum: MAXIMUM_FIRST_NAME_LENGTH }
  validates :last_name, presence: true, length: { maximum: MAXIMUM_LAST_NAME_LENGTH }
  validates :email, presence: true, length: { maximum: MAXIMUM_EMAIL_LENGTH },
                    uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: MINIMUM_PASSWORD_LENGTH }

  private

  def email_to_downcase
    self.email = email.downcase
  end
end
