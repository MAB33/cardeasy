class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :addresses, :dependent => :destroy
  has_many :cards, :dependent => :destroy

  before_save :capitalize_name

	def capitalize_name
		self.fname = self.fname.capitalize
		self.lname = self.lname.capitalize
	end

end
