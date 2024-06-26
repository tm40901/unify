class InspectionResult < ApplicationRecord
  belongs_to :instrument
  belongs_to :inspection_item
  belongs_to :inspector, class_name: "User"
  belongs_to :approver,  class_name: "User"

  with_options presence: true do
    validates :result, inclusion: { in: ["Pass", "Fail"] }
    validates :custom_id
    validates :status
  end
end
