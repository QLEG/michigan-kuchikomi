class KeijibanController < ApplicationController

  def index
    @communities = Community.all.limit(5)
    # @posts = Post.order(id: :desc).limit(20)
    @posts = Post.limit(20).sort_by{ |p| p.score}.reverse
    @vote = Vote.new
  end

end