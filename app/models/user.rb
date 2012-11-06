class User < ActiveRecord::Base

  after_save :setRoleAsCustomer
  before_save :ensure_authentication_token

  has_many :reservations	

  # Include default devise modules. Others available are:
  # , :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :address, :role, :email, :password, :password_confirmation, :remember_me, :cctype, :ccnumber, :ccvalidity, :authentication_token
  # attr_accessible :title, :body

  # invoked upon user registration
  def setRoleAsCustomer
    if self.role == "guest"
      
      self.update_attributes(:role => "customer")

    end
  end

  def promote
    if self.role == "customer"
      self.update_attributes(:role => "inspector")
    elsif self.role == "inspector"
      self.update_attributes(:role => "admin")
    end
  end

  def demote
    if self.role == "admin"
      self.update_attributes(:role => "inspector")
    elsif self.role == "inspector"
      self.update_attributes(:role => "customer")
    end
  end 
  
end
