class StaticPagesController < ApplicationController
  def home
    @post = Post.all.order(created_at: "DESC")
    gon.points = @post.pluck(:latitude, :longitude)

    @user_ranking = Post.group(:user_id).order('count(user_id) DESC').limit(3).pluck(:user_id)
    @area_ranking = Post.group(:point).order('count(point) DESC').limit(3).pluck(:point)
    @fav_ranking = Favorite.group(:post_id).order('count(post_id) DESC').limit(3).pluck(:post_id)

    @user = User.all
  end
end
