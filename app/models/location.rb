class Location < ActiveRecord::Base
  attr_accessible :city, :country, :region
  has_paper_trail
  self.per_page = 20

  # Associations
  has_and_belongs_to_many :companies
  has_and_belongs_to_many :investors

  # Validations
  validates :country, length: { in: 2..100 }
  validates :region,  length: { in: 2..100 }
  validates :city,    length: { in: 2..100 },
                      uniqueness: { scope: [ :country, :region ] }

  # Methods
  def full
    "#{self.city}, #{self.region}, #{self.country}"
  end

end
