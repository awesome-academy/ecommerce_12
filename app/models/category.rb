class Category < ApplicationRecord
  belongs_to :parent, class_name: Category.name, optional: true
  has_many :childrens, dependent: :destroy
    class_name: Category.name, foreign_key: :parent_id
  has_many :products, dependent: :destroy
end
