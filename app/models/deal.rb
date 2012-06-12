class Deal < ActiveRecord::Base
include ActionView::Helpers::NumberHelper

  CATEGORIES = ['financing round'] # 'acquisition', 'merger'
  ROUNDS = ['Seed', 'Series Seed', 'Series A', 'Series B', 'Series C', 'IPO']
  CURRENCIES = ['USD', 'BRL']
  attr_accessible :amount, :category, :close_date, :currency, :pre_valuation, :round, 
                  :source_url, :verified, :company_id, :investor_ids
  delegate :name, :to => :company, :prefix => true, :allow_nil => true
  has_paper_trail

  # Associations
  belongs_to :company
  has_and_belongs_to_many :investors

  #Validations
  validates :close_date, :presence => true
  validate  :close_date_must_be_today_or_before
  validate  :close_date_must_be_in_date_format
  validates :category, :inclusion => { :in => CATEGORIES }
  validates :round, :inclusion => { :in => ROUNDS }
  validates :currency, :inclusion => { :in => CURRENCIES }
  validates :amount, :numericality => { :only_integer => true, :greater_than => 0, :allow_nil => true }
  validates :pre_valuation, :numericality => { :only_integer => true, :greater_than => 0, :allow_nil => true }
  validates :source_url, :format => { :with => URL_REGEX, :allow_nil => true, :allow_blank => true }
  
  # Callbacks
  after_initialize :init
  
  def init
    self.verified = false if self.verified.nil?
  end

  # Methods
  def investor_name
    investors.collect {|investor| investor.name}.join(', ')
  end  

  def summary
    result = "#{company_name} raised a #{round} round"
    result += " of #{full_amount}" if amount
    result += " from #{investor_name}"
  end

  def full_amount
    "#{currency} #{number_with_delimiter(amount, :delimiter => ",")}"
  end

  private 
  def close_date_must_be_in_date_format
    unless close_date.is_a?(Date)
      errors.add(:close_date, "is missing or invalid")
    end
  end

  def close_date_must_be_today_or_before
    if close_date && close_date > Date.today
      errors.add(:close_date, "must be today or before")
    end
  end
end
