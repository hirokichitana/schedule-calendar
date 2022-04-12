require 'rails_helper'

RSpec.describe Schedule, type: :model do
  before do
    @schedule = FactoryBot.build(:schedule)
  end

  describe 'スケジュール新規投稿' do
    context '新規投稿できるとき' do
      it 'titleとcontent、start_time、end_timeが存在すれば登録できる' do
        expect(@schedule).to be_valid
      end
    end
    context '新規投稿できないとき' do
      it 'titleが空では登録できない' do
        @schedule.title = ''
        @schedule.valid?
        expect(@schedule.errors.full_messages).to include("Titleを入力してください")
      end
      it 'contentが空では登録できない' do
        @schedule.content = ''
        @schedule.valid?
        expect(@schedule.errors.full_messages).to include("Contentを入力してください")
      end
      it 'start_timeが空では登録できない' do
        @schedule.start_time = ''
        @schedule.valid?
        expect(@schedule.errors.full_messages).to include("Start timeを入力してください")
      end
      it 'end_timeが空では登録できない' do
        @schedule.end_time = ''
        @schedule.valid?
        expect(@schedule.errors.full_messages).to include("End timeを入力してください")
      end
      it 'zip_codeが6文字以下では登録できない' do
        @schedule.zip_code = '123456'
        @schedule.valid?
        expect(@schedule.errors.full_messages).to include("Zip codeは不正な値です")
      end
      it 'zip_codeが6文字以下では登録できない' do
        @schedule.zip_code = '12345678'
        @schedule.valid?
        expect(@schedule.errors.full_messages).to include("Zip codeは不正な値です")
      end
      it 'zip_codeが大文字では登録できない' do
        @schedule.zip_code = '１２３４５６７'
        @schedule.valid?
        expect(@schedule.errors.full_messages).to include("Zip codeは不正な値です")
      end
    end
  end
end
