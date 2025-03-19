class StaticPagesController < ApplicationController
  def home
    @post = Post.all.order(created_at: "DESC")
    gon.points = @post.pluck(:latitude, :longitude)
    

    @user_ranking = Post.group(:user_id).order('count(user_id) DESC').limit(3).pluck(:user_id)
    @fav_ranking = Favorite.group(:post_id).order('count(post_id) DESC').limit(3).pluck(:post_id)
    
    @area_ranking = Post.group(:point).order('count(point) DESC').pluck(:point)
    gon.area_ranking = @area_ranking.slice(0,10)
    gon.area_ranking_count = post_point_count(@area_ranking.slice(0,10))
 
    category_chart = Post.group(:category_id).order('count(category_id) DESC').limit(3).pluck(:category_id)
    gon.category_chart = id2name(category_chart)
    gon.category_chart_count = post_category_count(category_chart)

    @user = User.all
  end
end
