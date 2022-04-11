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
  end
end
