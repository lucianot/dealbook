class Search < ActiveRecord::Base
  attr_accessible :keywords

  def results
    query = keywords
    query = "TOTALLY_INVALID_QUERY" if keywords.nil? || keywords.strip.empty?
    search_for(query).results
  end

  private
  def search_for(query)
    Sunspot.search(Company, Investor) do
      fulltext query
    end
  end
end
