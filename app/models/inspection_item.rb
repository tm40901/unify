class InspectionItem < ApplicationRecord
  belongs_to :instrument
  
  with_options presence: true do
    validates :item
  end
end
