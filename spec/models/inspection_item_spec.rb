require 'rails_helper'

RSpec.describe InspectionItem, type: :model do
  before do
    @inspection_item = FactoryBot.build(:inspection_item)
  end

  describe '点検項目の登録' do

    context '登録できる場合' do
      it '必要な情報を適切に入力していれば保存できる' do
        expect(@inspection_item).to be_valid
      end
    end

    context '登録できない場合' do
      it 'itemが空では保存できない' do
        @inspection_item.item = ''
        @inspection_item.valid?
        expect(@inspection_item.errors.full_messages).to include("点検項目を入力してください")
      end
      it 'instrument_idが紐づいていないと保存できない' do
        @inspection_item.instrument = nil
        @inspection_item.valid?
        expect(@inspection_item.errors.full_messages).to include("Instrumentを入力してください")
      end
    end
  end
end
