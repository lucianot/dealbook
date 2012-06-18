module DealsHelper
  def buyer_collection
    Investor.all.map(&buyer_for_select) + Company.all.map(&buyer_for_select)
  end

  private
  def buyer_for_select
    lambda { |record| [record.name, "#{record.class.name}:#{record.id}"] }
  end
end