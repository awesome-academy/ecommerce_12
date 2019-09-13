class User < ApplicationRecord
  has_one :user_profile, dependent: :destroy
  has_many :suggests, dependent: :destroy
  has_many :orders
  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :destroy
  enum admin: {user: 0, admin: 1}

  validates :username, presence: true,
    length: {maximum: Settings.max_username}
  validates :email, presence: true,
    length: {maximum: Settings.max_email}
  has_secure_password
end
