class StagesIncludedValidator < ActiveModel::EachValidator
  # TODO: Send this to model
  STAGES = ['Seed', 'Series Seed', 'Series A', 'Series B', 'Series C', 'IPO']

  def validate_each(record, attribute, value)
    value.each do |s|
      record.errors[attribute] << 'must be included in the list' unless STAGES.include?(s)
    end
  end
end