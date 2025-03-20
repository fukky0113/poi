class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :show, :destroy] 
  before_action :correct_user, only: [:edit, :update] 
  before_action :admin_user, only: [:index, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      redirect_to @user, status: :see_other
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.where(user_id: params[:user_id]).page(params[:page]).per(21)
  end

  def edit
    @user = User.find(params[:user_id])
  end

  def update
    @user = User.find(params[:user_id])
    if @user.update(user_params)
      redirect_to @user, status: :see_other
    else 
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:user_id]).destroy
    redirect_to user_path, status: :see_other
  end

  private 
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
