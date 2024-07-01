require 'rails_helper'

RSpec.describe Reservation, type: :model do
  before do
    @reservation = FactoryBot.build(:reservation)
  end
  
  describe '予約の登録' do

    context '登録できる場合' do
      it '必要な情報を適切に入力していれば保存できる' do
        expect(@reservation).to be_valid
      end
    end

    context '登録できない場合' do
      it 'instrumentが空では保存できない' do
        @reservation.instrument = nil
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("計測器名を入力してください")
      end
      it 'start_timeが空では保存できない' do
        @reservation.start_time = ''
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("開始時間を入力してください")
      end
      it 'end_timeが空では保存できない' do
        @reservation.end_time = ''
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("終了時間を入力してください")
      end
      it 'end_time < start_timeでは保存できない' do
        @reservation.end_time = Time.now
        @reservation.start_time = 1.hour.from_now
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("開始時間が終了時間を超えることはできません")
      end
      it 'user_idが紐づいていないと保存できない' do
        @reservation.user = nil
        @reservation.valid?
        expect(@reservation.errors.full_messages).to include("Userを入力してください")
      end

    end
  end
end
