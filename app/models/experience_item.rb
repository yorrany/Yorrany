class ExperienceItem < ApplicationRecord
  has_one_attached :image
  extend Mobility
  include AutoTranslatable
  translates :role, type: :string
  translates :company, type: :string
  translates :period, type: :string
  translates :location, type: :string
  translates :type_name, type: :string
  translates :summary, type: :text
  translates :highlights, type: :text
  translates :skills, type: :string
end
