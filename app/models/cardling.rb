class Cardling < ActiveRecord::Base
  belongs_to :card
  belongs_to :order
  belongs_to :address
  #belongs_to :user, through: :cards

end
