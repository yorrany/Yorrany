# db/seeds_experiences.rb
I18n.locale = :'pt-BR'

puts "Cleaning up existing experience items..."
ExperienceItem.destroy_all

experiences = [
  {
    role: "Senior Product Designer & Brand Strategist",
    company: "Matterna",
    period: "Dez 2024 - Atual",
    location: "Manaus, Brasil",
    summary: "Concepção, design de produto e estratégia visual para plataforma focada em maternidade/maternagem. Atuação: Liderança completa do ciclo de design (Discovery, Design System, UX/UI, arquitetura de informação e estratégia de marca).\n\nEntrega: Construção da identidade visual, prototipação de alta fidelidade e estruturação de e-commerce e ecossistema digital focado em alta conversão e experiência do usuário.",
    highlights: "Projeto autoral focado em inovação de produto e validação de processos de design ponta a ponta.",
    type_name: "Tempo Integral",
    skills: "UX/UI Design, Branding, Estratégia de Produto, E-commerce, Design Systems"
  },
  {
    role: "Diretor de Arte",
    company: "Agência Taió",
    period: "Fev 2022 - Out 2023",
    location: "São José dos Campos, Brasil",
    summary: "Desenvolvimento de projetos de comunicação visual, design gráfico e branding para clientes de renome nacional.\n\nCriação de peças focadas em aumento de taxas de conversão e fortalecimento de reconhecimento de marca.",
    highlights: "",
    type_name: "Tempo Integral",
    skills: "Direção de Arte, Design Gráfico, Branding, Comunicação Visual"
  },
  {
    role: "Diretor de Arte",
    company: "BZ Propaganda & Marketing",
    period: "Dez 2021 - Abr 2022",
    location: "São José dos Campos, Brasil",
    summary: "Confeção e execução de campanhas publicitárias on-line e off-line para clientes de grande porte, como o Grupo Saboroso.\n\nDireção de arte e estratégias de design focadas no posicionamento de mercado.",
    highlights: "",
    type_name: "Tempo Integral",
    skills: "Campanhas Publicitárias, Posicionamento de Marca, Off-line e On-line"
  },
  {
    role: "Pesquisador Acadêmico",
    company: "ULBRA - Universidade Luterana do Brasil",
    period: "Mai 2021 - Out 2021",
    location: "Manaus, Brasil",
    summary: "Investigação científica e redação do Capítulo V (pp. 53-66) do livro *Educação em Saúde: gravidez na adolescência, bullying, prevenção de acidentes, envelhecimento e bem-estar na Amazônia*.\n\nAnálise psicossocial e elaboração de diagnósticos sobre impactos da gravidez precoce.",
    highlights: "",
    type_name: "Meio Período",
    skills: "Pesquisa Acadêmica, Análise Psicossocial, Redação Científica"
  },
  {
    role: "Assistente Universitário Estagiário",
    company: "ULBRA - Universidade Luterana do Brasil",
    period: "Dez 2020 - Jun 2021",
    location: "Manaus, Brasil",
    summary: "Prática observacional e elaboração de diagnósticos em psicopatologia e psicologia comunitária (Carga horária: 76h).",
    highlights: "",
    type_name: "Estágio",
    skills: "Psicopatologia, Psicologia Comunitária, Diagnóstico"
  },
  {
    role: "Diretor de Arte",
    company: "All Night Pub",
    period: "Mai 2016 - Jun 2017",
    location: "Manaus, Brasil",
    summary: "Gestão da identidade visual da marca, criação de materiais institucionais, cardápios e peças promocionais.\n\nGestão de mídias sociais e planeamento visual de campanhas.",
    highlights: "",
    type_name: "Tempo Integral",
    skills: "Gestão de Marca, Redes Sociais, Design Institucional"
  },
  {
    role: "Diretor de Arte",
    company: "Magic Publicidade",
    period: "Dez 2010 - Jan 2013",
    location: "Manaus, Brasil",
    summary: "Produção de materiais de campanhas on/off-line, gestão de prazos e fluxo de trabalho da equipe de criação.",
    highlights: "",
    type_name: "Tempo Integral",
    skills: "Produção Publicitária, Gestão de Projetos, Criação"
  }
]

experiences.each_with_index do |exp, index|
  item = ExperienceItem.create!(
    role: exp[:role],
    company: exp[:company],
    period: exp[:period],
    location: exp[:location],
    summary: exp[:summary],
    highlights: exp[:highlights],
    type_name: exp[:type_name],
    skills: exp[:skills],
    created_at: Time.now - index.days
  )
  puts "Created: #{item.role} at #{item.company}"
end

puts "Done seeding experiences!"
