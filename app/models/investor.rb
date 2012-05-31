class Investor < ActiveRecord::Base

  # Associations
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :markets
  has_and_belongs_to_many :deals
  has_many :companies, :through => :deals

  #Validations
  validates :name, :length => { :in => 2..100 },
                   :uniqueness => true
  validates :description, :length => { :maximum => 600 }
  validates :website, :format => { :with => URL_REGEX } 
  validates :linkedin, :format => { :with => LINKEDIN_REGEX }
  validates :status, :inclusion => { :in => INVESTOR_STATUSES, :allow_nil => true }
  validates :category, :inclusion => { :in => INVESTOR_CATEGORIES, :allow_nil => true }
  validate  :all_stages_must_be_included_in_list

  attr_accessible :category, :description, :linkedin, :name, :stage, :status, :website
  serialize :stage
  has_paper_trail

  private
  def all_stages_must_be_included_in_list
    if stage
      self.stage.each do |s|
        errors.add(:stage, "is not included in the list") unless INVESTOR_STAGES.include?(s)
      end
    end
  end
  
end







