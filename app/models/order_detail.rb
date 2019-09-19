class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :price, presence: true, format: {with: /\A\d+\z/}
  validates :quantily, presence: true, format: {with: /\A\d+\z/}
end
