class Market < ActiveRecord::Base
  attr_accessible :name
  # delegate :name, :to => :company, :prefix => true, :allow_nil => true
  has_paper_trail
  self.per_page = 20

  # Associations
  has_and_belongs_to_many :companies
  has_and_belongs_to_many :investors

  #Validations
  validates :name, :length => { :in => 2..100 },
                   :uniqueness => true

end
