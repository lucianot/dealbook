class Company < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :markets
  has_many :deals, :dependent => :destroy
  has_many :investors, :through => :deals

  #Validations
  url_regex = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  linkedin_company_regex = /(^$)|(^(http|https):\/\/[a-z0-9]+\.linkedin\.com\/company\/[0-9]+.*$)/ix
  STATUSES = %w[active inactive acquired merged]
  validates :name, :presence => true,
                   :length => { :in => 2..100 },
                   :uniqueness => true
  validates :description, :length => { :maximum => 600 }
  validates :website, :format => { :with => url_regex } 
  validates :linkedin, :format => { :with => linkedin_company_regex }
  validates :status, :inclusion => { :in => STATUSES, :allow_nil => true }

  attr_accessible :description, :linkedin, :name, :status, :website
end
