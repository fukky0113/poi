class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :show, :destroy] 
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
    @comment = Comment.where(user_id: @user)

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, status: :see_other
    else 
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path, status: :see_other
  end

  private 
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
