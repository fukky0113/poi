class StaticPagesController < ApplicationController
  def home
    @post = Post.all.order(created_at: "DESC")
    @user_ranking = Post.group(:user_id).order('count(user_id) DESC').limit(3).pluck(:user_id)
    @user = User.all
  end
end
