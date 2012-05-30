class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable, :omniauthable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_and_belongs_to_many :roles       

  ROLES = %w[admin moderator normal banned]
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  def has_role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

end
