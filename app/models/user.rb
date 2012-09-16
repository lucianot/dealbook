class User < ActiveRecord::Base
  ROLES = %w[admin moderator normal banned guest]
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :full_name, :password, :password_confirmation, :remember_me
  attr_accessible :provider, :uid
  attr_accessible :role, :as => :admin
  # attr_accessible :username, :title, :body

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Gems
  self.per_page = 20       

  # Validations
  validates :full_name, :presence => true, :length => { :in => (2..100) }
  validates :role, :inclusion => { :in => ROLES }

  # Callbacks
  after_initialize :init

  def init
    self.role ||= 'normal'
  end

  # Methods
  def self.find_for_linkedin_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      # user.email = 'user@example.com'
      # user.full_name = auth.info.nickname
    end
  end

  def is?(role)
    self.role == role.to_s.downcase
  end
end
