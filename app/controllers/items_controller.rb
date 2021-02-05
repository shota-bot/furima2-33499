class ItemsController < ApplicationController
  def index
    @items = Item.all.order(created_at: :DESC)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
  end

  private
  def item_params
    params.require(:item).permit(:name, :text, :price, :category_id, :postage_id, :prefecture_id, :day_id, :image).merge(user_id: current_user.id)
  end
end
