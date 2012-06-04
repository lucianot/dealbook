class Company < ActiveRecord::Base
  STATUSES = %w[active inactive acquired merged]  

  # Associations
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :markets
  has_many :deals #, :dependent => :destroy
  has_many :investors, :through => :deals

  #Validations
  validates :name, :length => { :in => 2..100 },
                   :uniqueness => true
  validates :description, :length => { :maximum => 600 }
  validates :website, :format => { :with => URL_REGEX, :allow_nil => true } 
  validates :linkedin, :format => { :with => LINKEDIN_COMPANY_REGEX, :allow_nil => true }
  validates :status, :inclusion => { :in => STATUSES, :allow_nil => true }

  attr_accessible :description, :linkedin, :name, :status, :website
  has_paper_trail
end
