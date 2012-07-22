class Investor < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  STATUSES = %w[active inactive acquired merged]
  CATEGORIES = %w[Angel VC Accelerator Incubator Corporate]
  STAGES = ['Seed', 'Series Seed', 'Series A', 'Series B', 'Series C', 'IPO']

  attr_accessible :category, :description, :linkedin, :name, :stage, :status, :website
  attr_accessible :market_ids, :location_ids  # TODO: make safer
  serialize :stage

  # Gems
  has_paper_trail
  self.per_page = 20
  include PgSearch
  pg_search_scope :exact, :against => { :name => 'A' },
                          :ignoring => :accents,
                          :using => {
                            :tsearch => {
                              :dictionary => "english",
                              :prefix => true
                            }
                          }
  pg_search_scope :associated,  :associated_against => {
                                  :locations => [:city, :region, :country],
                                  :markets => :name,
                                  :companies => { :name => 'A' }
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
  has_many :dealings, :as => :buyer
  has_many :deals, :through => :dealings
  has_many :companies, :through => :deals

  #Validations
  validates :name, :presence => true,
                   :length => { :in => 2..100 },
                   :uniqueness => true
  validates :description, :length => { :maximum => 600 }
  validates :website, :format => { :with => URL_REGEX }, :allow_nil => true, :allow_blank => true
  validates :linkedin, :format => { :with => LINKEDIN_REGEX }, :allow_nil => true, :allow_blank => true
  validates :status, :inclusion => { :in => STATUSES, :allow_nil => true }
  validates :category, :inclusion => { :in => CATEGORIES, :allow_nil => true }
  validate  :all_stages_must_be_included_in_list

  # Callbacks
  before_validation do
    stage.reject!(&:blank?) if stage  # remove hidden field
  end

  # Methods
  def markets_names
    markets.map(&:name).join(', ')
  end

  def locations_names
    locations.map(&:full).join(', ')
  end

  def companies_names
    companies.map(&:name).join(', ')
  end

  # FriendlyId gem
  def should_generate_new_friendly_id?
    new_record?
  end

  private
  def all_stages_must_be_included_in_list
    if stage
      self.stage.each do |s|
        errors.add(:stage, "is not included in the list") unless STAGES.include?(s)
      end
    end
  end
end







