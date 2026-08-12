class AcademicBackground < ApplicationRecord
  has_one_attached :image
  has_one_attached :certificate
  extend Mobility
  include AutoTranslatable
  translates :degree, type: :string
  translates :institution, type: :string
  translates :period, type: :string
  translates :field_of_study, type: :string
  translates :thesis, type: :string
  translates :research_focus, type: :text
end
