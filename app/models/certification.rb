class Certification < ApplicationRecord
  has_one_attached :image
  extend Mobility
  include AutoTranslatable
  translates :title, type: :string
  translates :issuer, type: :string
  translates :category, type: :string
  translates :description, type: :text
  translates :skills, type: :string

  default_scope { order(position: :asc, id: :desc) }

  before_create :set_default_position

  private

  def set_default_position
    self.position ||= (Certification.maximum(:position) || 0) + 1
  end
end
