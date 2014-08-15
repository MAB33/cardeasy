class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :addresses, :dependent => :destroy
  has_many :cards, :dependent => :destroy

  before_save :capitalize_name, :strip_whitespace

	def capitalize_name
		self.fname = self.fname.capitalize
		self.lname = self.lname.capitalize
	end

  def strip_whitespace
    self.fname = self.fname.strip unless self.fname.blank?
    self.lname = self.lname.strip unless self.lname.blank?
    self.email = self.email.strip unless self.email.blank?
  end

end
