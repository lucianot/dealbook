class Company < ActiveRecord::Base
  STATUSES = %w[active inactive acquired merged]
  attr_accessible :description, :linkedin, :name, :status, :website
  attr_accessible :market_ids, :location_ids  # TODO: make safer

  # Gems
  has_paper_trail
  self.per_page = 20
  include PgSearch
  pg_search_scope :exact, :against => { :name => 'A' },
                          :ignoring => :accents,
                          :using => {
                            :tsearch => {:dictionary => "english"}
                          }
  pg_search_scope :associated,  :associated_against => {
                                  :locations => [:city, :region, :country],
                                  :markets => :name,
                                  :investors => { :name => 'A' },
                                  :corporates => { :name => 'A' }
                                },
                                :ignoring => :accents,
                                :using => {
                                  :tsearch => {
                                    :dictionary => "english",
                                    :prefix => true
                                  }
                                }

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
  validates :name, :presence => true,
                   :length => { :in => 2..100 },
                   :uniqueness => true
  validates :description, :length => { :maximum => 600 }
  validates :website, :format => { :with => URL_REGEX, :allow_nil => true, :allow_blank => true }
  validates :linkedin, :format => { :with => LINKEDIN_COMPANY_REGEX, :allow_nil => true, :allow_blank => true }
  validates :status, :inclusion => { :in => STATUSES, :allow_nil => true }

  # Methods
  def markets_names
    markets.map(&:name).join(', ')
  end

  def locations_names
    locations.map(&:full).join(', ')
  end

  def buyers
    self.investors + self.corporates
  end

end
