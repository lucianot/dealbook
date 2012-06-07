class Investor < ActiveRecord::Base
  STATUSES = %w[active inactive acquired merged]
  CATEGORIES = %w[angel VC accelerator incubator corporate]
  STAGES = ['Seed', 'Series Seed', 'Series A', 'Series B', 'Series C', 'IPO']     
  attr_accessible :category, :description, :linkedin, :name, :stage, :status, :website, :market_ids
  serialize :stage
  has_paper_trail   

  # Associations
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :markets
  has_and_belongs_to_many :deals
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

  # Methods
  def market_name
    markets.collect {|market| market.name}.join(', ')
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







