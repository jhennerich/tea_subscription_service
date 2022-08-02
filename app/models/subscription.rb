class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates_presence_of :title, :price, :status, :frequency

  enum status: { cancelled: 0, active: 1 }
  enum frequency: { weekly: 0, monthly: 1 }
end
