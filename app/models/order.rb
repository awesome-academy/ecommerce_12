class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  has_many :products, through: :order_details
  enum status: {pending: 0, shipped: 1, cancelled: 2}

  validates :customer_name, presence: true,
    length: {minimum: Settings.min_customer_name,
             maximum: Settings.max_customer_name}
  validates :address, presence: true,
    length: {minimum: Settings.min_address,
             maximum: Settings.max_address}
  validates :phone, presence: true,
    length: {minimum: Settings.min_phone,
             maximum: Settings.max_phone},
    format: {with: /\A\d+\z/}

  scope :newest, ->{order created_at: :desc}
end
