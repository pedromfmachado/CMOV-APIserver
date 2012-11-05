class User < ActiveRecord::Base

  after_save :setRoleAsCustomer

  has_many :reservations	

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :address, :role, :email, :password, :password_confirmation, :remember_me, :cctype, :ccnumber, :ccvalidity
  # attr_accessible :title, :body

  def setRoleAsCustomer

    if self.role == "guest"
      
      self.update_attributes(:role => "customer")

    end

  end  
  
end
