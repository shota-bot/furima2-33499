class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order = UserOrder.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order = UserOrder.new(order_params)

    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.require(:user_order).permit(:postal_code, :prefecture_id, :city, :house_num, :building, :phone_num).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = "sk_test_af3c7c042497128dff46650b"
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
  end
end
