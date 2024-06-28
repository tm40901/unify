require 'rails_helper'

RSpec.describe InspectionResult, type: :model do
  before do
    @inspection_result = FactoryBot.build(:inspection_result)
  end
  
  describe '点検結果の登録' do

    context '登録できる場合' do
      it '必要な情報を適切に入力していれば保存できる' do
        expect(@inspection_result).to be_valid
      end
    end

    context '登録できない場合' do
      it 'resultが空では保存できない' do
        @inspection_result.result = ''
        @inspection_result.valid?
        expect(@inspection_result.errors.full_messages).to include("結果を入力してください")
      end
      it 'custom_idが空では保存できない' do
        @inspection_result.custom_id = ''
        @inspection_result.valid?
        expect(@inspection_result.errors.full_messages).to include("カスタムIDを入力してください")
      end
      it 'statusが空では保存できない' do
        @inspection_result.status = ''
        @inspection_result.valid?
        expect(@inspection_result.errors.full_messages).to include("ステータスを入力してください")
      end
      it 'insturment_idが紐づいていないと保存できない' do
        @inspection_result.instrument = nil
        @inspection_result.valid?
        expect(@inspection_result.errors.full_messages).to include("Instrumentを入力してください")
      end
      it 'inspection_item_idが紐づいていないと保存できない' do
        @inspection_result.inspection_item = nil
        @inspection_result.valid?
        expect(@inspection_result.errors.full_messages).to include("Inspection itemを入力してください")
      end
      it 'inspecor_idが紐づいていないと保存できない' do
        @inspection_result.inspector = nil
        @inspection_result.valid?
        expect(@inspection_result.errors.full_messages).to include("点検者を入力してください")
      end
      it 'approver_idが紐づいていないと保存できない' do
        @inspection_result.approver = nil
        @inspection_result.valid?
        expect(@inspection_result.errors.full_messages).to include("承認者を入力してください")
      end
    end
  end
end
