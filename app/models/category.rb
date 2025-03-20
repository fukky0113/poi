class Category < ApplicationRecord
  has_many :posts

  validates :g_type, presence: true, uniqueness: true
end
