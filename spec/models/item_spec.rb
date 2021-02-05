require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品を出品できる時' do
      it 'images,name,text,priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品できない時' do
      it 'nameが空だと登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'textが空だと登録できない' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Text can't be blank")
      end
      it 'imageに紐づいていないと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'userに紐づいていないと登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
      it 'categoryに紐づいていないと登録できない' do
        @item.category = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Category を選択して下さい')
      end
      it 'category_idが1だと登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category を選択して下さい')
      end
      it 'statusに紐づいていないと登録できない' do
        @item.status = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Status を選択して下さい')
      end
      it 'status_idが1だと登録できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Status を選択して下さい')
      end
      it 'posatageに紐づいていないと登録できない' do
        @item.postage = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Postage を選択して下さい')
      end
      it 'postage_idが1だと登録できない' do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Postage を選択して下さい')
      end
      it 'prefectureに紐づいていないと登録できない' do
        @item.prefecture = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture を選択して下さい')
      end
      it 'prefecture_idが1だと登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture を選択して下さい')
      end
      it 'dayに紐づいていないと登録できない' do
        @item.day = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Day を選択して下さい')
      end
      it 'day_idが1だと登録できない' do
        @item.day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Day を選択して下さい')
      end
      it 'pirceがないと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Price を300円〜9999999円以内で入力して下さい')
      end
      it 'priceが半角数字でないと登録できない' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price を300円〜9999999円以内で入力して下さい')
      end
      it 'priceが300より少ないと登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price を300円〜9999999円以内で入力して下さい')
      end
      it 'priceが10000000以上だと登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price を300円〜9999999円以内で入力して下さい')
      end
    end
  end
end
