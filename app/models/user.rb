class User < ApplicationRecord
  has_many :admin_instruments,     class_name: "Instrument", foreign_key: "admin_id"
  has_many :inspector_instruments, class_name: "Instrument", foreign_key: "inspector_id"

  has_many :inspector_inspection_results, class_name: "InspectionResult", foreign_key: "inspector_id"
  has_many :approver_inspection_results,  class_name: "InspectionResult", foreign_key: "approver_id"

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  with_options presence: true do
    validates :employee_number
    validates :last_name
    validates :first_name
    validates :department
    validates :role
  end
end
