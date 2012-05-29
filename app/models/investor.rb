class Investor < ActiveRecord::Base

  # Associations
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :markets
  has_many :deals, :dependent => :destroy
  has_many :companies, :through => :deals

  #Validations
  url_regex = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  linkedin_regex = /(^$)|(^(http|https):\/\/[a-z0-9]+\.linkedin\.com\/(company\/)?[0-9]+.*$)/ix
  STATUSES = %w[active inactive acquired merged]
  CATEGORIES = %w[angel VC accelerator incubator corporate]
  STAGES = ['Seed', 'Series Seed', 'Series A', 'Series B', 'Series C', 'IPO']

  validates :name, :presence => true,
                   :length => { :in => 2..100 },
                   :uniqueness => true
  validates :description, :length => { :maximum => 600 }
  validates :website, :format => { :with => url_regex } 
  validates :linkedin, :format => { :with => linkedin_regex }
  validates :status, :inclusion => { :in => STATUSES, :allow_nil => true }
  validates :category, :inclusion => { :in => CATEGORIES, :allow_nil => true }
  validate :all_stages_must_be_included_in_list

  attr_accessible :category, :description, :linkedin, :name, :stage, :status, :website
  serialize :stage

  private
  def all_stages_must_be_included_in_list
    if stage
      self.stage.each do |s|
        errors.add(:stage, "is not included in the list") unless STAGES.include?(s)
      end
    end
  end
  
end







