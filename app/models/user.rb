class User < ActiveRecord::Base
  ROLES = %w[admin moderator normal banned guest]

  attr_accessible :email, :full_name, :password, :password_confirmation, :remember_me, 
                  :provider, :uid
  attr_accessible :role, :as => :admin

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

  def is?(role)
    self.role == role.to_s.downcase
  end
  
  #OmniAuth
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.full_name = auth.info.name
      user.email = auth.info.email
      # user.password = Devise.friendly_token[0,20]
    end
  end
  
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
  
  def password_required?
    super && provider.blank?
  end
  
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
