class User < ApplicationRecord
  has_many :admin_instruments,     class_name: 'Instrument', foreign_key: 'admin_id'
  has_many :inspector_instruments, class_name: 'Instrument', foreign_key: 'inspector_id'
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  with_options presence: true do
    validates :employee_number
    validates :last_name
    validates :first_name
    validates :department
    validates :role
  end
end
