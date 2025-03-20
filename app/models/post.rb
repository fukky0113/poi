class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :favorites, dependent: :destroy

  has_many :comments

  # ActiveStorage向け
  has_one_attached :image

  validates :description, presence: true, length: { maximum: 255 }
  validates :category_id, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :user_id, presence: true

  def favorited_by?(user, post)
    Favorite.exists?(user_id: user.id, post_id: post.id)
  end
end
