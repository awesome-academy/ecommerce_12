class Seggest < ApplicationRecord
  belongs_to :user
  enum status: {pending: 0, cancelled: 1, success: 2}
end
