class Market < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :companies
  # has_and_belongs_to_many :investors

  #Validations
  validates :name, :presence => true,
                 :length => { :in => 2..100 },
                 :uniqueness => true

  attr_accessible :name
end
