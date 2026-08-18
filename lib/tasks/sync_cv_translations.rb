# frozen_string_literal: true

def sync_cv_translations!
  puts "Sincronizando traduções completas para itens do CV..."

  # 1. ACADEMIC BACKGROUNDS
  AcademicBackground.all.each do |a|
    a.skip_auto_translate = true
    if a.degree.to_s.include?("Psychology") || a.institution.to_s.include?("Santa Teresa")
      Mobility.with_locale(:"pt-PT") do
        a.degree = "Licenciatura em Psicologia"
        a.institution = "Faculdade Santa Teresa"
        a.field_of_study = "Psicologia Cognitiva e Comportamental aplicada a Produtos Digitais"
        a.thesis = "Fatores Psicossociais e Comportamentais na Adoção de Tecnologias"
      end
      Mobility.with_locale(:es) do
        a.degree = "Licenciatura en Psicología"
        a.institution = "Faculdade Santa Teresa"
        a.field_of_study = "Psicología Cognitiva y Conductual aplicada a Productos Digitales"
        a.thesis = "Factores Psicosociales y Conductuales en la Adopción de Tecnologías"
      end
      Mobility.with_locale(:en) do
        a.degree = "B.Sc. in Psychology"
        a.institution = "Faculdade Santa Teresa"
        a.field_of_study = "Cognitive & Behavioral Psychology applied to Digital Products"
        a.thesis = "Psychosocial and Behavioral Factors in Technology Adoption"
      end
    elsif a.degree.to_s.include?("High School") || a.degree.to_s.include?("Secundário") || a.degree.to_s.include?("Médio")
      Mobility.with_locale(:"pt-PT") do
        a.degree = "Ensino Secundário / Médio Completo"
        a.institution = "Colégio Estadual Professor José Carlos de Almeida"
      end
      Mobility.with_locale(:es) do
        a.degree = "Educación Secundaria Completa"
        a.institution = "Colégio Estadual Professor José Carlos de Almeida"
      end
      Mobility.with_locale(:en) do
        a.degree = "High School Diploma"
        a.institution = "Colégio Estadual Professor José Carlos de Almeida"
      end
    end
    a.save!
  end
  puts "✓ Formação acadêmica sincronizada nos 3 idiomas."

  # 2. EXPERIENCES
  ExperienceItem.all.each do |e|
    e.skip_auto_translate = true
    if e.company.to_s.downcase.include?("matterna")
      Mobility.with_locale(:"pt-PT") do
        e.role = "Senior Product Designer & Front-End Architect"
        e.type_name = "Tempo Integral"
        e.location = "Remoto • São Paulo, Brasil"
        e.summary = "Liderança de ponta a ponta em design de produto, design system e arquitetura de front-end para plataforma de saúde materno-infantil."
      end
      Mobility.with_locale(:en) do
        e.role = "Senior Product Designer & Front-End Architect"
        e.type_name = "Full-time"
        e.location = "Remote • São Paulo, Brazil"
        e.summary = "End-to-end product design leadership, design system governance, and front-end architecture for digital health."
      end
      Mobility.with_locale(:es) do
        e.role = "Diseñador de Producto Senior & Front-End Architect"
        e.type_name = "Tiempo Completo"
        e.location = "Remoto • São Paulo, Brasil"
        e.summary = "Liderazgo integral en diseño de producto, design system y arquitectura front-end para salud digital."
      end
    elsif e.company.to_s.downcase.include?("ulbra")
      Mobility.with_locale(:"pt-PT") do
        e.role = e.role.to_s.include?("Researcher") || e.role.to_s.include?("Pesquisador") ? "Pesquisador Académico" : "Assistente Universitário"
        e.type_name = "Académico"
        e.location = "Manaus, Brasil"
      end
      Mobility.with_locale(:en) do
        e.role = e.role.to_s.include?("Pesquisador") || e.role.to_s.include?("Researcher") ? "Academic Researcher" : "University Assistant"
        e.type_name = "Academic"
        e.location = "Manaus, Brazil"
      end
      Mobility.with_locale(:es) do
        e.role = e.role.to_s.include?("Pesquisador") || e.role.to_s.include?("Investigador") ? "Investigador Académico" : "Asistente Universitario"
        e.type_name = "Académico"
        e.location = "Manaus, Brasil"
      end
    else
      Mobility.with_locale(:"pt-PT") do
        e.role = "Diretor de Arte" if e.role.to_s == "Art Director"
        e.type_name = "Tempo Integral" if e.type_name.to_s.downcase.include?("full")
      end
      Mobility.with_locale(:es) do
        e.role = "Director de Arte" if e.role.to_s == "Art Director"
        e.type_name = "Tiempo Completo" if e.type_name.to_s.downcase.include?("full")
      end
      Mobility.with_locale(:en) do
        e.role = "Art Director" if e.role.to_s.include?("Diretor") || e.role.to_s.include?("Director")
        e.type_name = "Full-time" if e.type_name.to_s.downcase.include?("integral") || e.type_name.to_s.downcase.include?("completo")
      end
    end
    e.save!
  end
  puts "✓ Experiências profissionais sincronizadas nos 3 idiomas."

  # 3. CERTIFICATIONS
  Certification.all.each do |c|
    c.skip_auto_translate = true
    if c.title.to_s.include?("JavaScript Security")
      Mobility.with_locale(:"pt-PT") do
        c.title = "Introdução à Segurança em JavaScript (LFS184)"
        c.category = "Segurança & Front-End"
      end
      Mobility.with_locale(:es) do
        c.title = "Introducción a la Seguridad de JavaScript (LFS184)"
        c.category = "Seguridad & Front-End"
      end
      Mobility.with_locale(:en) do
        c.title = "Introduction to JavaScript Security (LFS184)"
        c.category = "Security & Front-End"
      end
    elsif c.title.to_s.include?("Python")
      Mobility.with_locale(:"pt-PT") do
        c.title = "Programação: da abstração à implementação em Python"
        c.category = "Engenharia de Software"
      end
      Mobility.with_locale(:es) do
        c.title = "Programación: de la abstracción a la implementación en Python"
        c.category = "Ingeniería de Software"
      end
      Mobility.with_locale(:en) do
        c.title = "Programming: from abstraction to implementation in Python"
        c.category = "Software Engineering"
      end
    end
    c.save!
  end
  puts "✓ Certificações sincronizadas nos 3 idiomas."
end

sync_cv_translations!
