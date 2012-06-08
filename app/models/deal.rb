class Deal < ActiveRecord::Base
  CATEGORIES = ['financing round', 'acquisition', 'merger']
  ROUNDS = ['Seed', 'Series Seed', 'Series A', 'Series B', 'Series C', 'IPO']
  attr_accessible :amount, :category, :deal_date, :pre_valuation, :round, :source_url
  delegate :name, :to => :company, :prefix => true, :allow_nil => true
  has_paper_trail

  # Associations
  belongs_to :company
  has_and_belongs_to_many :investors

  #Validations
  validates :deal_date, :presence => true
  validate  :deal_date_must_be_in_date_format
  validates :category, :inclusion => { :in => CATEGORIES }
  validates :round, :inclusion => { :in => ROUNDS }
  validates :amount, :numericality => { :only_integer => true, :greater_than => 0, :allow_nil => true }
  validates :pre_valuation, :numericality => { :only_integer => true, :greater_than => 0, :allow_nil => true }
  validates :source_url, :format => { :with => URL_REGEX, :allow_nil => true, :allow_blank => true }

  # Methods
  def investor_name
    investors.collect {|investor| investor.name}.join(', ')
  end  

  def summary
    result = "#{company_name} raised"
    result += " USD #{amount}" if amount
    result += " from #{investor_name}."
  end

  private 
  def deal_date_must_be_in_date_format
    unless deal_date.is_a?(Date)
      errors.add(:deal_date, "is missing or invalid")
    end
  end
end
