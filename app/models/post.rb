class Post < ApplicationRecord
  has_one_attached :cover_image
  extend Mobility
  include AutoTranslatable
  translates :title, type: :string
  translates :excerpt, type: :string
  translates :content, type: :text
end
