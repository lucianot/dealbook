class Deal < ActiveRecord::Base
  # Associations
  belongs_to :company
  has_and_belongs_to_many :investors

  #Validations
  validates :deal_date, :presence => true
  validate  :deal_date_must_be_in_date_format
  validates :category, :inclusion => { :in => DEAL_CATEGORIES }
  validates :round, :inclusion => { :in => DEAL_ROUNDS }
  validates :amount, :numericality => { :only_integer => true, :allow_nil => true }
  validates :pre_valuation, :numericality => { :only_integer => true, :allow_nil => true }
  validates :source_url, :format => { :with => URL_REGEX }
  # validates :company_id, :presence => true 

  attr_accessible :amount, :category, :deal_date, :pre_valuation, :round, :source_url

  private 
  def deal_date_must_be_in_date_format
    unless deal_date.is_a?(Date)
      errors.add(:deal_date, "is missing or invalid")
    end
  end
end
