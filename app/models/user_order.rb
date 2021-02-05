class UserOrder
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :house_num, :building, :phone_num, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'ハイフン(-)を入れてください' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :city
    validates :house_num
    validates :phone_num, format: { with: /\A\d{,11}\z/}
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_num: house_num, building: building, phone_num: phone_num, user_id: user_id, order_id: order.id)
  end
end