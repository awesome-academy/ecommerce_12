class Order < ApplicationRecord
  belongs_to :user
  has_many :products, through: :order_detail
  enum status: {pending: 0, shipped: 1, cancelled: 2}
end
