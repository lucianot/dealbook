class User < ActiveRecord::Base
	rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable, :omniauthable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # # Associations
  # has_and_belongs_to_many :roles       

  # Validations
  validates :full_name, :length => { :in => (2..100) }

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :full_name, :password, :password_confirmation, :remember_me
  # attr_accessible :username, :title, :body

  # Class methods
  def top_role
    roles = self.roles
    roles.first.name.titleize unless roles.empty?
  end
end
