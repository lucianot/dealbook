class Market < ActiveRecord::Base
  attr_accessible :name
  has_paper_trail  

  # Associations
  has_and_belongs_to_many :companies
  has_and_belongs_to_many :investors

  #Validations
  validates :name, :length => { :in => 2..100 },
                   :uniqueness => true
                   
end
