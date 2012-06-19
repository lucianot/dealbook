class Company < ActiveRecord::Base
  STATUSES = %w[active inactive acquired merged]  
  attr_accessible :description, :linkedin, :name, :status, :website
  attr_accessible :market_ids, :location_ids  # TODO: make safer
  has_paper_trail

  # # Sunspot/Solr
  # searchable do
  #   text :name, :boost => 3.0
  #   text :description
  #   text :market_names do
  #     markets.map(&:name)
  #   end
  #   text :location_names do
  #     locations.map(&:full)
  #   end  
  # end

  # Scopes
  scope :all_but_this, lambda {|id| id ? {conditions: ['id not in (?)', id]} : {} }

  # Associations
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :markets
  # as target
  has_many :offers, :foreign_key => 'company_id',
                    :class_name => 'Deal'
  has_many :offerings, :through => :offers
  has_many :investors, :through => :offerings, 
                       :source => :investor,
                       :conditions => "dealings.buyer_type = 'Investor'"
  has_many :corporates, :through => :offerings, 
                        :source => :corporate,
                        :conditions => "dealings.buyer_type = 'Company'"   
  # as buyer
  has_many :dealings, :as => :buyer
  has_many :deals, :through => :dealings
  has_many :companies, :through => :deals                      

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

  def location_name
    locations.collect {|location| location.full}.join(', ')
  end
end
