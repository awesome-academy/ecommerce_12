class User < ApplicationRecord
  has_one :user_profile, dependent: :destroy
  has_many :suggests, dependent: :destroy
  has_many :orders
  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :destroy
  enum admin: {user: 0, admin: 1}

  validates :username, presence: true,
    length: {minimum: Settings.min_username,
             maximum: Settings.max_username}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.max_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.min_password}, allow_nil: true
  has_secure_password
end
