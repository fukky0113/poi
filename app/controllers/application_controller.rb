class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include SessionsHelper

  private
  
  def logged_in_user
    unless logged_in?
      store_location
      redirect_to login_url, status: :see_other
    end
  end

  def admin_user
    unless current_user.admin
      redirect_to root_path, status: :see_other
    end
  end

  def post_point_count(area_ranking)
    rank = []
    total = 0
    area_ranking.each do |area_rank|
      count = Post.where(point: area_rank).count
      rank.push(count)
      total += count
    end
    rank.push(Post.count-total)
    return rank
  end

  def post_category_count(category_chart)
    rank = []
    category_chart.each do |category|
      count = Post.where(category_id: category).count
      rank.push(count)
    end
    return rank
  end

  def id2name(category_chart)
    ret = []
    category_chart.each do |category|
      name = Category.find(category).g_type
      ret.push(name)
    end
    return ret
  end
end
