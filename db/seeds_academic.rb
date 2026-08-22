require 'dotenv/load'

puts "Cleaning up existing academic backgrounds..."
AcademicBackground.destroy_all

# Bacharelado em Psicologia
ab1 = AcademicBackground.create!(
  period: "Fev 2019 - Atual",
  created_at: Time.current
)
I18n.locale = :'pt-PT'
ab1.update!(
  degree: "Bacharelado",
  institution: "Faculdade Santa Teresa",
  field_of_study: "Psicologia",
  research_focus: "Formação abrangente em Ciências Humanas e Psicologia, com foco em Psicologia Organizacional, Psicologia Comunitária, Saúde Pública e Psicopatologia.\n\nAtividades de destaque:\n• Investigação Científica: Coautor do capítulo V ('Desvendando os malefícios da gravidez precoce em pré-adolescentes e adolescentes') na obra Educação em Saúde: gravidez na adolescência, bullying, prevenção de acidentes, envelhecimento e bem-estar na Amazônia (ULBRA, 2021).\n• Estágio em Psicopatologia: Prática observacional e elaboração de diagnósticos focados em processos grupais, psicologia comunitária e saúde pública (Carga horária: 76h).",
  thesis: "Desvendando os malefícios da gravidez precoce para pré-adolescentes e adolescentes (Publicado em capítulo de livro - ULBRA)."
)
if ab1.respond_to?(:enqueue_auto_translate_job)
  ab1.enqueue_auto_translate_job
end
puts "Created: Bacharelado em Psicologia at Faculdade Santa Teresa"

# Ensino Secundário
ab2 = AcademicBackground.create!(
  period: "Jan 2005 - Dez 2006",
  created_at: 1.day.ago
)
I18n.locale = :'pt-PT'
ab2.update!(
  degree: "Ensino Secundário",
  institution: "Colégio Estadual Professor José Carlos de Almeida",
  field_of_study: "Formação Geral e Científica",
  research_focus: "Formação geral e científica do ensino secundário, com carga horária total de 3.200 horas.\n\nPrincipais componentes curriculares: Língua Portuguesa, Matemática, Física, Química, Biologia, História, Geografia, Filosofia, Arte e Línguas Estrangeiras (Inglês e Espanhol).",
  thesis: nil
)
if ab2.respond_to?(:enqueue_auto_translate_job)
  ab2.enqueue_auto_translate_job
end
puts "Created: Ensino Secundário at Colégio Estadual Professor José Carlos de Almeida"

puts "Done seeding academic backgrounds!"
