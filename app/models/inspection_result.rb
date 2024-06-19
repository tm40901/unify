class InspectionResult < ApplicationRecord
  belongs_to :instrument

  with_options presence: true do
    validates :result
  end
end
