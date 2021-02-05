class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :day

  with_options presence: true do
    validates :name
    validates :text
    validates :price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'を300円〜9999999円以内で入力して下さい' }
    validates :image
    with_options numericality: { other_than: 1, message: 'を選択して下さい' } do
      validates :category_id
      validates :status_id
      validates :postage_id
      validates :prefecture_id
      validates :day_id
    end
  end
end
