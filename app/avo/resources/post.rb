class Avo::Resources::Post < Avo::BaseResource
  self.title = :title
  self.includes = []

  def fields
    field :id, as: :id
    field :slug, as: :text
    field :cover_image, as: :file, is_image: true
    field :title, as: :text
    field :excerpt, as: :textarea
    field :content, as: :markdown
    field :published_at, as: :date_time
  end
end
