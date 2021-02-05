class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々]/.freeze
  NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze
  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :password, format: { with: PASSWORD_REGEX, message: 'は英字と数字の両方を含めて設定してください' }
    with_options format: { with: NAME_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' } do
      validates :last_name
      validates :first_name
    end
    with_options format: { with: NAME_KANA_REGEX, message: 'は全角カタカナで入力してください' } do
      validates :last_name_kana
      validates :first_name_kana
   end
 end
end
