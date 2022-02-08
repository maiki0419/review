class Category < ApplicationRecord
  belongs_to :book
  validates :name,length: {maximum: 10}
end
