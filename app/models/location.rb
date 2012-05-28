class Location < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :companies
  has_and_belongs_to_many :investors

  #Validations
  validates :country, :presence => true,
                      :length => { :in => 2..100 },
                      :uniqueness => true
  validates :region,  :length => { :in => 2..100 }
  validates :city,    :presence => true,
                      :length => { :in => 2..100 } 


  attr_accessible :city, :country, :region
end
