class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :product_images, dependent: :destroy
  has_many :order_details
  has_many :orders, through: :order_details

  validates :name, presence: true,
    length: {maximum: Settings.max_product_name}
  validates :description, presence: true
  validates :price, presence: true
  validates :quantily, presence: true

  scope :sorted, ->{order created_at: :desc}
  scope :by_ids, ->(ids){where id: ids}
  scope :price_by_id, ->(id){where(id: id).first.price}
end
