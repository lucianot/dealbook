class User < ActiveRecord::Base
  has_many :authentications
  ROLES = %w[admin moderator normal banned guest]
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :full_name, :password, :password_confirmation, :remember_me
  attr_accessible :role, :as => :admin
  
  # attr_accessible :username, :title, :body

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates :full_name, :presence => true, :length => { :in => (2..100) }
  validates :role, :inclusion => { :in => ROLES }

  # Callbacks
  after_initialize :init

  def init
    self.role ||= 'normal'
  end

  # Class methods
  def is?(role)
    self.role == role.to_s.downcase
  end
  
  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

end
