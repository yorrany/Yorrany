class Avo::Resources::ExperienceItem < Avo::BaseResource
  # self.icon = "tabler/outline/users"
  # self.avatar = {
  #   source: :avatar
  # }
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :role, as: :text, name: "Cargo / Posição"
    field :company, as: :text, name: "Empresa"
    field :type_name, as: :text, name: "Tipo (Contrato)", help: "Ex: Full-time, CLT, PJ, Freelance"
    field :location, as: :text, name: "Localização"
    field :period, as: :text, name: "Período", help: "Ex: Jan 2020 - Present"
    field :summary, as: :textarea, name: "Descrição / Resumo"
    field :highlights, as: :textarea, name: "Destaques", help: "Separe os itens com '||' (ex: Liderança||Design System)"
    field :skills, as: :text, name: "Skills", help: "Separe por vírgula (ex: UX, UI, Ruby)"
  end
end
