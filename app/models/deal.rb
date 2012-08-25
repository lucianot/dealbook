class Deal < ActiveRecord::Base
include ActionView::Helpers::NumberHelper

  CATEGORIES = ['raised funds from', 'incubated by', 'merged with', 'was acquired by', 'shut down']
  ROUNDS = ['Acceleration', 'Seed', 'Series Seed', 'Series A', 'Series B', 'Series C',
            'Series D', 'Series E', 'IPO']
  CURRENCIES = ['USD', 'BRL']
  attr_accessible :amount, :category, :close_date, :currency, :pre_valuation, :round,
                  :source_url, :verified
  attr_accessible :company_id, :offerings, :investor_ids
  delegate :name, :to => :company, :prefix => true, :allow_nil => true
  has_paper_trail
  self.per_page = 12

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
  after_initialize :set_defaults
  before_update :make_deal_unverified, :if => :attributes_changed?

  # Methods
  def buyers
    self.investors + self.corporates
  end

  def buyers_name
    buyers.collect {|buyer| buyer.name}.join(', ') unless buyers.empty?
  end

  # TODO move to presenter
  def summary
    case category
    when 'raised funds from'
      result = "raised"
      if amount
        result += " #{full_amount} in"
        result += " #{round}" if round
        result += " funding"
      else
        result += " funds"
      end
      result += " from" unless buyers.empty?
    else
      result = category
    end
    return result
  end

  def headline
    result = company_name
    result += " #{summary}"
    result += " #{buyers_name}"
    return result
  end

  def full_amount
    "#{currency} #{number_with_delimiter(amount, :delimiter => ",")}"
  end

  def buyers_for_options
    collection = (Investor.all + Company.all).sort_by {|buyer| buyer.name.downcase }
    collection.map { |record| [record.name, "#{record.class.name}:#{record.id}"] }
  end

  def buyers_for_selected
    buyers.map { |buyer| "#{buyer.class.name}:#{buyer.id}" }
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

  def set_defaults
    self.verified = false if self.verified.nil?  # Deal should be unverified by default
  end
  
  def make_deal_unverified
    self.verified = false
    return true
  end

  def attributes_changed?
    changed = self.changed

    # Remove source_url from changed on tests, to fix Capybara bug that alters url 
    changed.delete('source_url') #unless Rails.env.development? || Rails.env.production?

    # Check if no fields were changed
    if changed.empty?
      return false
    # Check if the only change is on verified field
    elsif changed.size == 1 && changed.include?('verified')
      return false
    else
      return true
    end
  end

end
