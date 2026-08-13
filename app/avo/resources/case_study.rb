class Avo::Resources::CaseStudy < Avo::BaseResource
  self.title = :title
  self.includes = [:image_attachment, :gallery_images_attachments]

  def fields
    field :id, as: :id

    # Identidade do Projeto
    field :title, as: :text, placeholder: "Ex: Redesign Plataforma de Saúde Digital", help: "Título principal do case study"
    field :tagline, as: :text, placeholder: "Frase curta de impacto", help: "Subtítulo ou slogan do projeto"
    field :client, as: :text, placeholder: "Nome do cliente ou empresa"
    field :role, as: :text, placeholder: "Ex: Lead Product Designer"
    field :period, as: :text, placeholder: "Ex: 2023 — 2024"
    field :tags, as: :text, placeholder: "Product Design, UX/UI, E-Commerce", help: "Separados por vírgula"

    # Configurações Visuais
    field :is_spotlight, as: :boolean, help: "Marque para destacar este projeto como principal na Home"
    field :accent_color, as: :text, placeholder: "#003CA5", help: "Cor de destaque hexadecimal (opcional)"

    # Imagens
    field :image, as: :file, is_image: true, help: "Imagem de capa principal do projeto"
    field :gallery_images, as: :files, help: "Galeria de imagens adicionais do projeto"

    # Conteúdo Descritivo
    field :summary, as: :textarea, rows: 3, placeholder: "Resumo executivo do projeto...", help: "Visível nos cards da Home"
    field :challenge, as: :textarea, rows: 4, placeholder: "Qual era o problema ou desafio enfrentado?", help: "Contexto e dores do projeto"
    field :solution, as: :textarea, rows: 4, placeholder: "Qual foi a abordagem e a solução desenvolvida?", help: "Estratégia e execução"
    field :behavioral_insight, as: :textarea, rows: 3, placeholder: "Insight comportamental aplicado...", help: "Diferencial de psicologia/HCI"
    field :full_description, as: :markdown, help: "Descrição completa com formatação rica (visível na página interna do case)"
  end
end

