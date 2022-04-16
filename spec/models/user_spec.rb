require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nameとtelephone_number、email、password、password_confirmation、birth_dateが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it 'telephone_numberが空だと保存できないこと' do
        @user.telephone_number = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('電話番号を入力してください')
      end
      it 'telephone_numberが9桁以下だと保存できないこと' do
        @user.telephone_number = '123456789'
        @user.valid?
        expect(@user.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'telephone_numberが12桁以上だと保存できないこと' do
        @user.telephone_number = '123456789012'
        @user.valid?
        expect(@user.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'telephone_numberが全角数字だと保存できないこと' do
        @user.telephone_number = '０９０１２３４５６７８'
        @user.valid?
        expect(@user.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'telephone_numberはハイフンを含んでいると保存できないこと' do
        @user.telephone_number = '090-1234-5678'
        @user.valid?
        expect(@user.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'test.test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'passwordは半角英数字混合でなければ登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12tes'
        @user.password_confirmation = '12tes'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'birth_dateが空では登録出来ない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end
    end
  end
end
