class PostsController < ApplicationController
  before_action :logged_in_user, only: [ :index, :new, :create, :show, :destroy ]
  before_action :correct_user, only: [ :index, :new, :create, :show, :destroy ]

  def index
    @post = Post.all.order(created_at: "DESC")
    @post = @post.page(params[:page]).per(21)
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = params[:user_id]

    results = Geocoder.search([ @post.latitude, @post.longitude ],  params: { 'accept-language': "ja" })

    @post.point = "不明"
    if results.first
      points = results.first.address.split(",")
      points.each do |point|
        if point[-1] == "都" or point[-1] == "道" or point[-1] == "府" or point[-1] == "県"
          @post.point = point.gsub(" ", "")
        end
      end
    end

    if @post.save
      redirect_to root_path, status: :see_other
    else
      render "new", status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.where(post_id: params[:id])
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @category = Category.find(@post.category_id)
    gon.point = [ @post.latitude, @post.longitude ]
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to request.referer, status: :see_other
  end

  private
  def post_params
    params.require(:post).permit(:image, :description, :category_id, :latitude, :longitude)
  end
end
