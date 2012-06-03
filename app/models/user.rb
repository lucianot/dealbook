class User < ActiveRecord::Base
  ROLES = %w[admin moderator normal banned guest]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable, :omniauthable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable   

  # Validations
  validates :full_name, :length => { :in => (2..100) }
  validates :role, :inclusion => { :in => ROLES }

  # Callbacks
  after_initialize :init

  def init
    self.role ||= 'normal'
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :full_name, :password, :password_confirmation, :remember_me, :role
  # attr_accessible :username, :title, :body

end
