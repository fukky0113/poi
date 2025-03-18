class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :favorites

  has_many :comments

  # ActiveStorage向け
  has_one_attached :image

  def favorited_by?(user, post)
    Favorite.exists?(user_id: user.id, post_id: post.id)
  end
end
