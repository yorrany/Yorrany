class SoftwareSkill < ApplicationRecord
  has_one_attached :icon
  default_scope { order(position: :asc) }
end
