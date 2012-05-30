class Role < ActiveRecord::Base
  # Validations
  validates :name, :inclusion => { :in => USER_ROLES }

  # Associations
  has_and_belongs_to_many :users

  attr_accessible :name
end
