class User::CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  before_action :correct_user, only: [:create]

  def create 
    @comment = Comment.new(comments_params)
    @comment.user_id = params[:user_id]
    @comment.post_id = params[:post_id]

    if @comment.save
      redirect_to user_post_path(user_id: @comment.user_id, id: @comment.post_id), status: :see_other
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def destroy

  end

  private
  def comments_params
    params.require(:comment).permit(:comment)
  end

end
