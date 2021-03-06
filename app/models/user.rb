class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  # Associations
  has_many :emails
  has_many :email_accounts
  has_many :folders, :through => :email_accounts
  
  # Helpers
  def to_s
    return "" unless email.present?
    
    return email
  end
end
