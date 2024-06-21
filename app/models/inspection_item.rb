class InspectionItem < ApplicationRecord
  belongs_to :instrument
  has_many :inspection_results, dependent: :destroy

  with_options presence: true do
    validates :item
  end
end
