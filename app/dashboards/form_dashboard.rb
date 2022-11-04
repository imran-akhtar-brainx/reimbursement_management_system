require "administrate/base_dashboard"

class FormDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    _type: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze
  COLLECTION_ATTRIBUTES = %i[
    id
    _type
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    _type
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    _type
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
