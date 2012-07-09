class Search < ActiveRecord::Base
  attr_accessible :keywords

  def results
    results = PgSearch.multisearch(keywords)
    results.map(&:searchable)
  end

end
