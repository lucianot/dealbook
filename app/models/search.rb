class Search < ActiveRecord::Base
  attr_accessible :keywords
  self.per_page = 2

end
