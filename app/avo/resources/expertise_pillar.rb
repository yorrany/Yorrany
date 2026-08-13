class Avo::Resources::ExpertisePillar < Avo::BaseResource
  self.title = :title
  self.includes = []
  self.routing_extension = -> {
    collection do
      patch :reorder
    end
  }

  def fields
    field :id, as: :id
    field :image, as: :file, is_image: true
    field :title, as: :text
    field :description, as: :markdown
    field :position, as: :number, hidden: true
  end
end
