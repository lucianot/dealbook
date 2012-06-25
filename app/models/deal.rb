class Deal < ActiveRecord::Base
include ActionView::Helpers::NumberHelper

  CATEGORIES = ['raised funds from', 'incubated by', 'merged with', 'was acquired by', 'shut down']
  ROUNDS = ['Acceleration', 'Seed', 'Series Seed', 'Series A', 'Series B', 'Series C', 'IPO']
  CURRENCIES = ['USD', 'BRL']
  attr_accessible :amount, :category, :close_date, :currency, :pre_valuation, :round, 
                  :source_url, :verified
  attr_accessible :company_id, :offerings, :investor_ids
  delegate :name, :to => :company, :prefix => true, :allow_nil => true
  has_paper_trail
  self.per_page = 10

  # Associations
  belongs_to :company
  has_many :offerings, :foreign_key => 'deal_id',
                       :class_name => 'Dealing',
                       :dependent => :destroy
  has_many :investors, :through => :offerings, :source => :buyer, :source_type => 'Investor'
  has_many :corporates, :through => :offerings, :source => :buyer, :source_type => 'Company' 

  #Validations
  validates :close_date, :presence => true
  validate  :close_date_must_be_today_or_before
  validate  :close_date_must_be_in_date_format
  validates :category, :inclusion => { :in => CATEGORIES }
  validates :round, :inclusion => { :in => ROUNDS }, :allow_blank => true
  validates :currency, :inclusion => { :in => CURRENCIES }, :allow_blank => true
  validates :amount, :numericality => { :only_integer => true, :greater_than => 0 },
                                        :allow_blank => true
  validates :pre_valuation, :numericality => { :only_integer => true, :greater_than => 0 }, 
                                               :allow_blank => true
  validates :source_url, :format => { :with => URL_REGEX, :allow_nil => true, 
                                      :allow_blank => true }
  validates :company_id, :presence => true, :allow_blank => false
  validate :corporates_cannot_include_target_company
  
  # Callbacks
  after_initialize :init  
  def init
    self.verified = false if self.verified.nil?  # Deal should be unverified by default
  end

  # Methods
  def buyers
    self.investors + self.corporates
  end

  def buyers_name
    buyers.collect {|buyer| buyer.name}.join(', ') unless buyers.empty?
  end  

  def summary
    result = "#{company_name}"
    result += " raised a #{round} round" if round
    result += " of #{full_amount}" if amount
    result += " from #{buyers_name}" if buyers_name
    result
  end

  def full_amount
    "#{currency} #{number_with_delimiter(amount, :delimiter => ",")}"
  end

  def buyer_collection
    # filtered_companies = Company.all_but_this(self.company)
    collection = (Investor.all + Company.all).sort_by {|buyer| buyer.name.downcase }
    collection.map(&buyer_for_select)
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

  def corporates_cannot_include_target_company
    corporates.each do |corporate|
      errors.add(:corporates, "cannot include target company.") if corporate == company
    end
  end
 
  def buyer_for_select
    lambda { |record| [record.name, "#{record.class.name}:#{record.id}"] }
  end
end
