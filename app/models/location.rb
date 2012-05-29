class Location < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :companies
  has_and_belongs_to_many :investors

  #Validations
  validates :country, :length => { :in => 2..100 }
  validates :region,  :length => { :in => 2..100 }
  validates :city,    :length => { :in => 2..100 },
                      :uniqueness => { :scope => [ :country, :region ] } 

  attr_accessible :city, :country, :region
end
