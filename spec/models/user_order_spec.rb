require 'rails_helper'

RSpec.describe Order, type: :model do
 before do
   @user_order = FactoryBot.build(:user_order)
 end

  describe 'データを保存する' do
    context '保存できる' do
      it '全ての値があれば保存できる' do
        expect(@user_order).to be_valid
      end
      it 'buildingの値がなくても保存できる' do
        @user_order.building = ''
        expect(@user_order).to be_valid
      end
    end

    context '保存できない' do
      it 'postal_codeが空だと登録できない' do
        @user_order.postal_code = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角数字出ないと登録できない' do
        @user_order.postal_code = '１２３-４５６７'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('Postal code ハイフン(-)を入れてください')
      end
      it 'postal_codeがハイフンを含まないと登録できない' do
        @user_order.postal_code = '1234567'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('Postal code ハイフン(-)を入れてください')
      end
      it 'prefecture_idが1だと登録できない' do
        @user_order.prefecture_id = 1
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Prefecture を選択してください")
      end
      it 'prefecture_idと紐づいていないと登録できない' do
        @user_order.prefecture_id = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと登録できない' do
        @user_order.city = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numが空だと登録できない' do
        @user_order.house_num = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("House num can't be blank")
      end
      it 'phone_numが空だと登録できない' do
        @user_order.phone_num = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Phone num can't be blank")
      end
      it 'phone_numが半角数字でないと登録できない' do
        @user_order.phone_num = '１２３４５６７８９１０'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('Phone num is invalid')
      end
      it 'phone_numが12桁以上だと登録できない' do
        @user_order.phone_num = '123456789101'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('Phone num is invalid')
      end
      it 'tokenが空だと登録できない' do
        @user_order.token = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが空だと登録できない' do
        @user_order.user_id = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと登録できない' do
        @user_order.item_id = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end