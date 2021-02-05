require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー登録' do
    context 'ユーザー登録ができる時' do
      it 'nickname, email, password, password_confirmation, last_name, first_name, last_name_kana, first_name_kana, birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上の英数字混合なら登録できる' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end
      it 'last_name, first_nameが漢字・ひらがな・カタカナなら登録できる' do
        @user.last_name = '青あおアオ'
        @user.first_name = '白しろシロ'
        expect(@user).to be_valid
      end
      it 'last_name_kana, first_name_kanaがカタカナなら登録できる' do
        @user.last_name_kana = 'アオ'
        @user.first_name_kana = 'シロ'
        expect(@user).to be_valid
      end
    end

    context 'ユーザー登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailだと登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it '@を含まないemailは登録できない' do
        @user.email = 'aoao.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.password_confirmation = '123abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下だと登録できない' do
        @user.password = '123ab'
        @user.password_confirmation = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが英字のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は英字と数字の両方を含めて設定してください')
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は英字と数字の両方を含めて設定してください')
      end
      it 'passwordを入力してもpassword_comfirmationが空だと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_comfirmationが一致しないと登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'last_nameが空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_nameが漢字・ひらがな・カタカナでないと登録できない' do
        @user.last_name = 'aiu'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name は全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'first_nameが漢字・ひらがな・カタカナでないと登録できない' do
        @user.first_name = 'ueo'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'last_name_kanaが空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana は全角カタカナで入力してください')
      end
      it 'first_name_kanaが空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カタカナで入力してください')
      end
      it 'last_name_kanaがカタカナでないと登録できない' do
        @user.last_name_kana = 'あいう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana は全角カタカナで入力してください')
      end
      it 'first_name_kanaがカタカナでないと登録できない' do
        @user.first_name_kana = 'うえお'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana は全角カタカナで入力してください')
      end
      it 'birthdayが空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
