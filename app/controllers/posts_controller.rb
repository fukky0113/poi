class PostsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :show :edit, :update, :destroy]

  def index
  end
  
  def new
  end

  def create 
  end

  def show
  end

  def end
  end

  def update
  end

  def destroy
  end

end
