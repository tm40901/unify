require 'rails_helper'

RSpec.describe Instrument, type: :model do
  before do
    @instrument = FactoryBot.build(:instrument)
  end
  
  describe '計測器の登録' do

    context '登録できる場合' do
      it '必要な情報を適切に入力していれば保存できる' do
        expect(@instrument).to be_valid
      end
      it 'manufacturerが空でも保存できる' do
        @instrument.manufacturer = ''
        expect(@instrument).to be_valid
      end
      it 'modelが空でも保存できる' do
        @instrument.model = ''
        expect(@instrument).to be_valid
      end
      it 'serial_numberが空でも保存できる' do
        @instrument.serial_number = ''
        expect(@instrument).to be_valid
      end
      it 'last_inspected_atが空でも保存できる' do
        @instrument.last_inspected_at = ''
        expect(@instrument).to be_valid
      end
    end

    context '登録できない場合' do
      it 'nameが空では保存できない' do
        @instrument.name = ''
        @instrument.valid?
        expect(@instrument.errors.full_messages).to include("計測器名を入力してください")
      end
      it 'management_numberが空では保存できない' do
        @instrument.management_number = ''
        @instrument.valid?
        expect(@instrument.errors.full_messages).to include("管理番号を入力してください")
      end
      it '重複したmanagement_numberが存在する場合は登録できない' do
        @instrument.save
        another_instrument = FactoryBot.build(:instrument)
        another_instrument.management_number = @instrument.management_number
        another_instrument.valid?
        expect(another_instrument.errors.full_messages).to include("管理番号はすでに存在します")
      end
      it 'admin_idが紐づいていないと保存できない' do
        @instrument.admin = nil
        @instrument.valid?
        expect(@instrument.errors.full_messages).to include("管理者を入力してください")
      end
      it 'inspector_idが紐づいていないと保存できない' do
        @instrument.inspector = nil
        @instrument.valid?
        expect(@instrument.errors.full_messages).to include("点検者を入力してください")
      end
    end
  end
end
