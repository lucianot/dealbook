class Search < ActiveRecord::Base
  attr_accessible :keywords

  def results
    query = keywords
    query = "TOTALLY_INVALID_QUERY" if keywords.nil? || keywords.strip.empty?
    PgSearch.multisearch(query)
    # search_for(query).results
  end

end
