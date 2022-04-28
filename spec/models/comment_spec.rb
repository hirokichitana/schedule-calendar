require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント新規投稿' do
    context '新規投稿できるとき' do
      it 'textが存在すれば登録できる' do
        expect(@comment).to be_valid
      end
    end
    context '新規投稿できないとき' do
      it 'textが空では登録できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Textを入力してください')
      end
    end
  end
end
