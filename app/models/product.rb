class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :product_images, dependent: :destroy
  has_many :order_details
  has_many :orders, through: :order_detail
end
