class Company < ActiveRecord::Base
  STATUSES = %w[active inactive acquired merged]  
  attr_accessible :description, :linkedin, :name, :status, :website, :market_ids
  has_paper_trail

  # Associations
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :markets
  has_many :deals #, :dependent => :destroy
  has_many :investors, :through => :deals

  #Validations
  validates :name, :length => { :in => 2..100 },
                   :uniqueness => true
  validates :description, :length => { :maximum => 600 }
  validates :website, :format => { :with => URL_REGEX, :allow_nil => true, :allow_blank => true } 
  validates :linkedin, :format => { :with => LINKEDIN_COMPANY_REGEX, :allow_nil => true, :allow_blank => true }
  validates :status, :inclusion => { :in => STATUSES, :allow_nil => true }

  # Methods
  def market_name
    markets.collect {|market| market.name}.join(', ')
  end
end
