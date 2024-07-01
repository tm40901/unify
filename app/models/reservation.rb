class Reservation < ApplicationRecord
  belongs_to :instrument
  belongs_to :user

  with_options presence: true do
    validates :start_time
    validates :end_time
  end

  validate :start_must_be_before_end
  private
  def start_must_be_before_end
    if start_time && end_time
      errors.add(:start_time, "が終了時間を超えることはできません") unless
          start_time < end_time
    end
  end
end
