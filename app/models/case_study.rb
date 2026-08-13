class CaseStudy < ApplicationRecord
  has_one_attached :image
  has_many_attached :gallery_images
  extend Mobility
  include AutoTranslatable
  translates :title, type: :string
  translates :tagline, type: :string
  translates :client, type: :string
  translates :role, type: :string
  translates :period, type: :string
  translates :summary, type: :text
  translates :full_description, type: :text
  translates :challenge, type: :text
  translates :solution, type: :text
  translates :behavioral_insight, type: :text
  translates :tags, type: :string
end
