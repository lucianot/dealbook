class Search < ActiveRecord::Base
  include FriendlyId
  friendly_id :keywords, use: :slugged

  attr_accessible :keywords
end
