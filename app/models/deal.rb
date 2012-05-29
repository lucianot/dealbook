class Deal < ActiveRecord::Base
  # Associations
  belongs_to :company
  belongs_to :investor

  #Validations
  url_regex = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  CATEGORIES = ['financing round', 'acquisition', 'merger']
  ROUNDS = ['Seed', 'Series Seed', 'Series A', 'Series B', 'Series C', 'IPO']
  validates :deal_date, :presence => true
  validate  :deal_date_must_be_in_date_format
  validates :category, :inclusion => { :in => CATEGORIES }
  validates :round, :inclusion => { :in => ROUNDS }
  validates :amount, :numericality => { :only_integer => true, :allow_nil => true }
  validates :pre_valuation, :numericality => { :only_integer => true, :allow_nil => true }
  validates :source_url, :format => { :with => url_regex }
  # validates :company_id, :presence => true 

  attr_accessible :amount, :category, :deal_date, :pre_valuation, :round, :source_url

  private 
  def deal_date_must_be_in_date_format
    unless deal_date.is_a?(Date)
      errors.add(:deal_date, "is missing or invalid")
    end
  end
end
