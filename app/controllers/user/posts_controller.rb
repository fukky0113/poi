class User::PostsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :show, :destroy]
  before_action :correct_user, only: [:index, :new, :create, :show, :destroy]

  def index
    @post = Post.all
  end
  
  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create 
    @post = Post.new(post_params)
    @post.user_id = params[:user_id]

    if @post.save
      redirect_to root_path, status: :see_other
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.where(post_id: params[:id])
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to user_path, status: :see_other
  end

  private
  def post_params
    params.require(:post).permit(:description, :category_id)
  end

end
