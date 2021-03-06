# This model is just a convenience wrapper for the relevant search query params, for use with FormHelper in the view.
class SearchParams
  include ActiveModel::Model

  attr_accessor :q, :sort, :direction, :status_open, :status_closed,
                :assigned_to_me, :assigned_to_someone_else, :assigned_to_someone_else_id, :sort_by

  def initialize(attributes = {})
    attributes.keys.each { |name| class_eval { attr_accessor name } } # Add any additional query attributes to the model
    super(attributes)
  end
end
