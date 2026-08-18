# Seed admin user
User.find_or_create_by!(email: 'admin@yorrany.com.br') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
end

# Seed Software Skills
skills_data = [
  { name: "Figma & Design Tokens", experience_years: 10, position: 1 },
  { name: "Ruby on Rails", experience_years: 8, position: 2 },
  { name: "Tailwind CSS", experience_years: 6, position: 3 },
  { name: "TypeScript & JavaScript", experience_years: 12, position: 4 },
  { name: "React & Modern Front-End", experience_years: 7, position: 5 },
  { name: "Python & Data / Automation", experience_years: 5, position: 6 },
  { name: "Design Systems (0 → 1)", experience_years: 12, position: 7 },
  { name: "Psicologia Cognitiva & IHC", experience_years: 8, position: 8 },
  { name: "Linux, Security & Docker", experience_years: 6, position: 9 },
  { name: "Adobe Creative Cloud", experience_years: 18, position: 10 },
  { name: "PostgreSQL & Database Design", experience_years: 8, position: 11 },
  { name: "WCAG & Acessibilidade AAA", experience_years: 10, position: 12 }
]

skills_data.each do |data|
  SoftwareSkill.find_or_create_by!(name: data[:name]) do |s|
    s.experience_years = data[:experience_years]
    s.position = data[:position]
  end
end

# Seed Expertise Pillars
pillars_data = [
  {
    title_pt: "Design Systems que Escalam",
    desc_pt: "Construção de ecossistemas visuais (0 → 1) com tokens sincronizados entre Figma e código (Tailwind/CSS). Redução de 40% no tempo de desenvolvimento e consistência absoluta de marca.",
    title_en: "Design Systems at Scale",
    desc_en: "Building 0-to-1 visual ecosystems with design tokens synced between Figma and production code. Drastically cuts dev cycles while ensuring absolute brand consistency.",
    title_es: "Sistemas de Diseño Escalables",
    desc_es: "Construcción de ecosistemas visuales (0 → 1) con tokens sincronizados entre Figma y código. Reducción de tiempos de desarrollo y consistencia absoluta de marca.",
    position: 1
  },
  {
    title_pt: "Psicologia Cognitiva & IHC",
    desc_pt: "Aplicações de heurísticas comportamentais e redução de carga cognitiva para desenhar fluxos intuitivos. Interfaces desenhadas para a mente humana com alta conversão e previsibilidade.",
    title_en: "Cognitive Psychology & HCI",
    desc_en: "Applying behavioral heuristics and cognitive load reduction to craft intuitive user flows. Interfaces designed for the human brain that drive ethical, high-converting results.",
    title_es: "Psicología Cognitiva e IHC",
    desc_es: "Aplicación de heurísticas conductuales y reducción de carga cognitiva para diseñar flujos intuitivos con alta conversión y predictibilidad.",
    position: 2
  },
  {
    title_pt: "Arquitetura Front-End & Segurança",
    desc_pt: "Fim do abismo entre design e engenharia. Código limpo, componentização semântica, segurança JS/Python verificada e foco em acessibilidade (WCAG AAA) e performance extrema.",
    title_en: "Front-End Architecture & Security",
    desc_en: "Bridging the gap between design and engineering. Clean semantic code, verified JS/Python security, WCAG AAA accessibility, and blazing fast performance.",
    title_es: "Arquitectura Front-End y Seguridad",
    desc_es: "Eliminando la brecha entre diseño e ingeniería. Código limpio, seguridad JS/Python verificada, accesibilidad WCAG AAA y rendimiento ultra rápido.",
    position: 3
  }
]

pillars_data.each do |p_data|
  pillar = ExpertisePillar.where(position: p_data[:position]).first_or_initialize
  I18n.with_locale(:'pt-PT') do
    pillar.title = p_data[:title_pt]
    pillar.description = p_data[:desc_pt]
  end
  I18n.with_locale(:en) do
    pillar.title = p_data[:title_en]
    pillar.description = p_data[:desc_en]
  end
  I18n.with_locale(:es) do
    pillar.title = p_data[:title_es]
    pillar.description = p_data[:desc_es]
  end
  pillar.position = p_data[:position]
  pillar.save!
end

puts "Seeds executados com sucesso! Skills: #{SoftwareSkill.count}, Pillars: #{ExpertisePillar.count}"
