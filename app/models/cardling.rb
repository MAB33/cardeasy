class Cardling < ActiveRecord::Base
  belongs_to :card
  belongs_to :order
  belongs_to :address
  has_one :user, through: :orders

end
