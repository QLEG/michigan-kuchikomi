class CommunitiesController < ApplicationController
  before_action :logged_in_user, except: [ :index, :show ]
  # before_action :logged_in_user, only: [ :new, :create ]
  before_action :set_community, only: [:show]

  def index
    @communities = Community.all
  end

  def show
    @posts = Post.limit(20).sort_by{ |p| p.score}.reverse
    @subscriber_count = @community.subscribers.count
    @is_subscribed = logged_in? ? Subscription.where(community_id: @community.id, user_id: current_user.id).any? : false
    @subscription = Subscription.new
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new community_values
    @community.user_id = current_user.id

    if @community.save
      redirect_to communities_path
    else
      render :new
    end
  end

    private

    def set_community
      @community = Community.find(params[:id])
      
    end

    def community_values
      params.require(:community).permit(:name, :url, :summary, :rules)
    end
end