class Instrument < ApplicationRecord
  belongs_to :admin,     class_name: "User"
  belongs_to :inspector, class_name: "User"
  has_many   :inspection_items
  has_many   :inspection_results
  has_many   :reservations

  with_options presence: true do
    validates :name
    validates :management_number, uniqueness: true
  end
end
