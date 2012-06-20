class Investor < ActiveRecord::Base
  STATUSES = %w[active inactive acquired merged]
  CATEGORIES = %w[Angel VC Accelerator Incubator Corporate]
  STAGES = ['Seed', 'Series Seed', 'Series A', 'Series B', 'Series C', 'IPO']     
  attr_accessible :category, :description, :linkedin, :name, :stage, :status, :website
  attr_accessible :market_ids, :location_ids  # TODO: make safer
  serialize :stage
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

  # Associations
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :markets
  has_many :dealings, :as => :buyer
  has_many :deals, :through => :dealings
  has_many :companies, :through => :deals

  #Validations
  validates :name, :length => { :in => 2..100 },
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
  def market_name
    markets.collect {|market| market.name}.join(', ')
  end  

  def location_name
    locations.collect {|location| location.full}.join(', ')
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







