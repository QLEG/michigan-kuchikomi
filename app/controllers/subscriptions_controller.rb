class SubscriptionsController < ApplicationController

  def create
    if current_user
      @subscription = Subscription.new(subscription_params)
      @subscription.user_id = current_user.id
      @subscription.save
      redirect_to community_path(@subscription.community_id)
    else
      flash[:danger] = "コミュニティにJoinしたりコメントするためにはログインしてください"
      redirect_to login_path
    end
  end

  def subscription_params
    params.require(:subscription).permit(:community_id)
    
  end
end