class PostsController < ApplicationController
  before_action :logged_in_user, except: [ :index, :show ]
  # before_action :logged_in_user, only: [ :new, :create ]
  before_action :set_post, only: [:show]
  before_action :authorized_subscriber, only: [:new]
  before_action :admin_user, only: :destroy

  def index
    @posts = Post.all
  end

  def show
    @community = Community.find(params[:community_id])
    @comment = Comment.new
  end

  def new
    @community = Community.find(params[:community_id])
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    @post.community_id = params[:community_id]
    @post.image.attach(params[:post][:image])
    if @post.save
      redirect_to community_path(@post.community_id)
    else
      @community = Community.find(params[:community_id])
      render :new
    end
    
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "ポストが削除されました"
    redirect_to keijiban_url
  end

    private

    def post_params
      params.require(:post).permit(:title, :body, :image)
    end

    def set_post
      @post = Post.includes(:comments).find(params[:id])
    end

    def authorized_subscriber
      unless Subscription.where(community_id: params[:community_id], user_id: current_user.id).any?
      redirect_to community_path(params[:community_id]), flash: {danger: "You are notauthorized to create new post! Please join the community first!" }
      end
    end

    def post_values
      params.require(:post).permit(:title, :body)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end