class Avo::Resources::SoftwareSkill < Avo::BaseResource
  self.title = :name
  self.includes = []
  self.routing_extension = -> {
    collection do
      patch :reorder
    end
  }

  def fields
    field :id, as: :id
    field :icon, as: :file, is_image: true
    field :name, as: :text
    field :experience_years, as: :number
    field :position, as: :number, hidden: true
  end
end
