class User::FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new
    @favorite.user_id = params[:user_id]
    @favorite.post_id = params[:post_id]
    @favorite.save
    redirect_to request.referer
  end

  def destroy
    Favorite.find_by(user_id: params[:user_id], post_id: params[:post_id]).destroy
    redirect_to request.referer
  end
end
