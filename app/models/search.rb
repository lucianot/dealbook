class Search < ActiveRecord::Base
  include FriendlyId
  friendly_id :keywords

  attr_accessible :keywords
end
