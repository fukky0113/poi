class CommentsController < ApplicationController
  before_action :logged_in_user, only: [ :create, :destroy ]
  before_action :correct_user, only: [ :create ]

  def create
    @comment = Comment.new
    @comment.user_id = params[:user_id]
    @comment.post_id = params[:post_id]
    @comment.comment = params[:comment]

    if @comment.save
      redirect_to user_post_path(user_id: @comment.user_id, id: @comment.post_id), status: :see_other
    else
      render "post/show", status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.user == current_user
      Comment.find(params[:id]).destroy
      redirect_to request.referer, status: :see_other
    else
      render "post/show", status: :unprocessable_entity
    end
  end
end
