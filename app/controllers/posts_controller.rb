class PostsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :show, :destroy]

  def index
    @post = Post.all
  end
  
  def new
  end

  def create 
  end

  def show
    user = User.find(params[:id])
    @comment = Comment.where(user_id: user)
  end

  def destroy
  end

end
