class ExpertisePillar < ApplicationRecord
  has_one_attached :image
  extend Mobility
  include AutoTranslatable
  translates :title, type: :string
  translates :description, type: :text
  
  default_scope { order(position: :asc) }
end
