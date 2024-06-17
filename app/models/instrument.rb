class Instrument < ApplicationRecord
  belongs_to :admin,     class_name: 'User'
  belongs_to :inspector, class_name: 'User'

  with_options presence: true do
    validates :name
    validates :management_number
  end
end
