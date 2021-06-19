class GoodsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def index
    # @goods = Good.all.limit(20)
    @goods = Good.paginate(page: params[:page])
  end

  def show
    @good = Good.find(params[:id])
  end

  def new
    @good = Good.new
  end

  def create
    @good = current_user.goods.build(good_params)
    @good.image.attach(params[:good][:image])
    if @good.save
      flash[:success] = "商品が投稿されました！"
      redirect_to goods_path
    else
      flash[:danger] = "商品の投稿に失敗しました"
      render :new
    end
  end

  def destroy
    Good.find(params[:id]).destroy
    flash[:success] = "商品は削除されました"
    redirect_to goods_url
  end

  private

    def good_params
      params.require(:good).permit(:name, :goods_condition, :delivery_condition, :area, :description, :price, :size, :image)
    end
end
