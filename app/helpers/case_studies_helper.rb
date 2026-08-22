# frozen_string_literal: true

module CaseStudiesHelper
  CATEGORY_TRANSLATIONS = {
    "Design Gráfico" => { "pt-PT" => "Design Gráfico", "en" => "Graphic Design", "es" => "Diseño Gráfico" },
    "Graphic Design" => { "pt-PT" => "Design Gráfico", "en" => "Graphic Design", "es" => "Diseño Gráfico" },
    "Diseño Gráfico" => { "pt-PT" => "Design Gráfico", "en" => "Graphic Design", "es" => "Diseño Gráfico" },
    "Product Design" => { "pt-PT" => "Product Design", "en" => "Product Design", "es" => "Diseño de Producto" },
    "Design de Produto" => { "pt-PT" => "Product Design", "en" => "Product Design", "es" => "Diseño de Producto" },
    "Diseño de Producto" => { "pt-PT" => "Product Design", "en" => "Product Design", "es" => "Diseño de Producto" },
    "UI/UX Design" => { "pt-PT" => "UI/UX Design", "en" => "UI/UX Design", "es" => "Diseño UI/UX" },
    "UI/UX" => { "pt-PT" => "UI/UX Design", "en" => "UI/UX Design", "es" => "Diseño UI/UX" },
    "Diseño UI/UX" => { "pt-PT" => "UI/UX Design", "en" => "UI/UX Design", "es" => "Diseño UI/UX" },
    "Interface e exp. do usuário" => { "pt-PT" => "UI/UX Design", "en" => "UI/UX Design", "es" => "Diseño UI/UX" },
    "Estratégia de Marca" => { "pt-PT" => "Estratégia de Marca", "en" => "Brand Strategy", "es" => "Estrategia de Marca" },
    "Brand Strategy" => { "pt-PT" => "Estratégia de Marca", "en" => "Brand Strategy", "es" => "Estrategia de Marca" },
    "Estrategia de Marca" => { "pt-PT" => "Estratégia de Marca", "en" => "Brand Strategy", "es" => "Estrategia de Marca" },
    "Branding" => { "pt-PT" => "Branding", "en" => "Branding", "es" => "Branding" },
    "Estratégia Digital" => { "pt-PT" => "Estratégia Digital", "en" => "Digital Strategist", "es" => "Estrategia Digital" },
    "Digital Strategist" => { "pt-PT" => "Estratégia Digital", "en" => "Digital Strategist", "es" => "Estrategia Digital" },
    "Digital Strategy" => { "pt-PT" => "Estratégia Digital", "en" => "Digital Strategy", "es" => "Estrategia Digital" },
    "Estrategia Digital" => { "pt-PT" => "Estratégia Digital", "en" => "Digital Strategist", "es" => "Estrategia Digital" },
    "Publicidade" => { "pt-PT" => "Publicidade", "en" => "Advertising", "es" => "Publicidad" },
    "Advertising" => { "pt-PT" => "Publicidade", "en" => "Advertising", "es" => "Publicidad" },
    "Publicidad" => { "pt-PT" => "Publicidade", "en" => "Advertising", "es" => "Publicidad" },
    "Direção de Arte" => { "pt-PT" => "Direção de Arte", "en" => "Art Direction", "es" => "Dirección de Arte" },
    "Direção artística" => { "pt-PT" => "Direção de Arte", "en" => "Art Direction", "es" => "Dirección de Arte" },
    "Art Direction" => { "pt-PT" => "Direção de Arte", "en" => "Art Direction", "es" => "Dirección de Arte" },
    "Dirección de Arte" => { "pt-PT" => "Direção de Arte", "en" => "Art Direction", "es" => "Dirección de Arte" },
    "E-Commerce" => { "pt-PT" => "E-Commerce", "en" => "E-Commerce", "es" => "E-Commerce" },
    "Web Design" => { "pt-PT" => "Web Design", "en" => "Web Design", "es" => "Diseño Web" },
    "Social Media" => { "pt-PT" => "Social Media", "en" => "Social Media", "es" => "Redes Sociales" }
  }.freeze

  TAG_TRANSLATIONS = {
    # Design & UI/UX
    "Design de interações" => { "pt-PT" => "Design de Interações", "en" => "Interaction Design", "es" => "Diseño de Interacción" },
    "Interaction Design" => { "pt-PT" => "Design de Interações", "en" => "Interaction Design", "es" => "Diseño de Interacción" },
    "Diseño de Interacción" => { "pt-PT" => "Design de Interações", "en" => "Interaction Design", "es" => "Diseño de Interacción" },
    "UI/UX Design" => { "pt-PT" => "UI/UX Design", "en" => "UI/UX Design", "es" => "Diseño UI/UX" },
    "UI/UX" => { "pt-PT" => "UI/UX Design", "en" => "UI/UX Design", "es" => "Diseño UI/UX" },
    "Diseño UI/UX" => { "pt-PT" => "UI/UX Design", "en" => "UI/UX Design", "es" => "Diseño UI/UX" },
    "Product Design" => { "pt-PT" => "Product Design", "en" => "Product Design", "es" => "Diseño de Producto" },
    "Diseño de Producto" => { "pt-PT" => "Product Design", "en" => "Product Design", "es" => "Diseño de Producto" },
    "Design System" => { "pt-PT" => "Design System", "en" => "Design System", "es" => "Design System" },
    "Figma" => { "pt-PT" => "Figma", "en" => "Figma", "es" => "Figma" },
    "Mobile App" => { "pt-PT" => "App Mobile", "en" => "Mobile App", "es" => "App Móvil" },
    "App Mobile" => { "pt-PT" => "App Mobile", "en" => "Mobile App", "es" => "App Móvil" },
    "App Móvil" => { "pt-PT" => "App Mobile", "en" => "Mobile App", "es" => "App Móvil" },

    # Graphic & Print Design
    "Design Gráfico" => { "pt-PT" => "Design Gráfico", "en" => "Graphic Design", "es" => "Diseño Gráfico" },
    "Graphic Design" => { "pt-PT" => "Design Gráfico", "en" => "Graphic Design", "es" => "Diseño Gráfico" },
    "Diseño Gráfico" => { "pt-PT" => "Design Gráfico", "en" => "Graphic Design", "es" => "Diseño Gráfico" },
    "Direção de Arte" => { "pt-PT" => "Direção de Arte", "en" => "Art Direction", "es" => "Dirección de Arte" },
    "Art Direction" => { "pt-PT" => "Direção de Arte", "en" => "Art Direction", "es" => "Dirección de Arte" },
    "Dirección de Arte" => { "pt-PT" => "Direção de Arte", "en" => "Art Direction", "es" => "Dirección de Arte" },
    "Impressos" => { "pt-PT" => "Impressos", "en" => "Print Design", "es" => "Impresos" },
    "Print Design" => { "pt-PT" => "Impressos", "en" => "Print Design", "es" => "Impresos" },
    "Impresos" => { "pt-PT" => "Impressos", "en" => "Print Design", "es" => "Impresos" },
    "Editorial" => { "pt-PT" => "Editorial", "en" => "Editorial", "es" => "Editorial" },
    "Design de Informação" => { "pt-PT" => "Design de Informação", "en" => "Information Design", "es" => "Diseño de Información" },
    "Information Design" => { "pt-PT" => "Design de Informação", "en" => "Information Design", "es" => "Diseño de Información" },
    "Diseño de Información" => { "pt-PT" => "Design de Informação", "en" => "Information Design", "es" => "Diseño de Información" },
    "Grids" => { "pt-PT" => "Grids", "en" => "Grids", "es" => "Retículas" },
    "Retículas" => { "pt-PT" => "Grids", "en" => "Grids", "es" => "Retículas" },
    "Tipografia" => { "pt-PT" => "Tipografia", "en" => "Typography", "es" => "Tipografía" },
    "Tipografía" => { "pt-PT" => "Tipografia", "en" => "Typography", "es" => "Tipografía" },
    "Typography" => { "pt-PT" => "Tipografia", "en" => "Typography", "es" => "Tipografía" },

    # Branding & Strategy
    "Branding" => { "pt-PT" => "Branding", "en" => "Branding", "es" => "Branding" },
    "Identidade Visual" => { "pt-PT" => "Identidade Visual", "en" => "Visual Identity", "es" => "Identidad Visual" },
    "Visual Identity" => { "pt-PT" => "Identidade Visual", "en" => "Visual Identity", "es" => "Identidad Visual" },
    "Identidad Visual" => { "pt-PT" => "Identidade Visual", "en" => "Visual Identity", "es" => "Identidad Visual" },
    "Identidade de Marca" => { "pt-PT" => "Identidade de Marca", "en" => "Brand Identity", "es" => "Identidad de Marca" },
    "Brand Identity" => { "pt-PT" => "Identidade de Marca", "en" => "Brand Identity", "es" => "Identidad de Marca" },
    "Identidad de Marca" => { "pt-PT" => "Identidade de Marca", "en" => "Brand Identity", "es" => "Identidad de Marca" },
    "Estratégia de Marca" => { "pt-PT" => "Estratégia de Marca", "en" => "Brand Strategy", "es" => "Estrategia de Marca" },
    "Brand Strategy" => { "pt-PT" => "Estratégia de Marca", "en" => "Brand Strategy", "es" => "Estrategia de Marca" },
    "Estrategia de Marca" => { "pt-PT" => "Estratégia de Marca", "en" => "Brand Strategy", "es" => "Estrategia de Marca" },
    "Design de Luxo" => { "pt-PT" => "Design de Luxo", "en" => "Luxury Design", "es" => "Diseño de Lujo" },
    "Luxury Design" => { "pt-PT" => "Design de Luxo", "en" => "Luxury Design", "es" => "Diseño de Lujo" },
    "Diseño de Lujo" => { "pt-PT" => "Design de Luxo", "en" => "Luxury Design", "es" => "Diseño de Lujo" },
    "Branding Médico" => { "pt-PT" => "Branding Médico", "en" => "Medical Branding", "es" => "Branding Médico" },
    "Medical Branding" => { "pt-PT" => "Branding Médico", "en" => "Medical Branding", "es" => "Branding Médico" },
    "Cultura Regional" => { "pt-PT" => "Cultura Regional", "en" => "Regional Culture", "es" => "Cultura Regional" },
    "Regional Culture" => { "pt-PT" => "Cultura Regional", "en" => "Regional Culture", "es" => "Cultura Regional" },

    # E-Commerce & Packaging
    "E-Commerce" => { "pt-PT" => "E-Commerce", "en" => "E-Commerce", "es" => "E-Commerce" },
    "Packaging" => { "pt-PT" => "Packaging", "en" => "Packaging", "es" => "Packaging" },
    "Design Sustentável" => { "pt-PT" => "Design Sustentável", "en" => "Sustainable Design", "es" => "Diseño Sostenible" },
    "Sustainable Design" => { "pt-PT" => "Design Sustentável", "en" => "Sustainable Design", "es" => "Diseño Sostenible" },
    "Diseño Sostenible" => { "pt-PT" => "Design Sustentável", "en" => "Sustainable Design", "es" => "Diseño Sostenible" },

    # Digital, Motion & Marketing
    "Estratégia Digital" => { "pt-PT" => "Estratégia Digital", "en" => "Digital Strategy", "es" => "Estrategia Digital" },
    "Digital Strategy" => { "pt-PT" => "Estratégia Digital", "en" => "Digital Strategy", "es" => "Estrategia Digital" },
    "Estrategia Digital" => { "pt-PT" => "Estratégia Digital", "en" => "Digital Strategy", "es" => "Estrategia Digital" },
    "Social Media" => { "pt-PT" => "Social Media", "en" => "Social Media", "es" => "Redes Sociales" },
    "Redes Sociales" => { "pt-PT" => "Social Media", "en" => "Social Media", "es" => "Redes Sociales" },
    "Motion Design" => { "pt-PT" => "Motion Design", "en" => "Motion Design", "es" => "Motion Design" },
    "Conteúdo Visual" => { "pt-PT" => "Conteúdo Visual", "en" => "Visual Content", "es" => "Contenido Visual" },
    "Visual Content" => { "pt-PT" => "Conteúdo Visual", "en" => "Visual Content", "es" => "Contenido Visual" },
    "Contenido Visual" => { "pt-PT" => "Conteúdo Visual", "en" => "Visual Content", "es" => "Contenido Visual" },
    "Engajamento" => { "pt-PT" => "Engajamento", "en" => "Engagement", "es" => "Engagement" },
    "Engagement" => { "pt-PT" => "Engajamento", "en" => "Engagement", "es" => "Engagement" },
    "Marketing Visual" => { "pt-PT" => "Marketing Visual", "en" => "Visual Marketing", "es" => "Marketing Visual" },
    "Visual Marketing" => { "pt-PT" => "Marketing Visual", "en" => "Visual Marketing", "es" => "Marketing Visual" },

    # Advertising & Campaign
    "Publicidade" => { "pt-PT" => "Publicidade", "en" => "Advertising", "es" => "Publicidad" },
    "Advertising" => { "pt-PT" => "Publicidade", "en" => "Advertising", "es" => "Publicidad" },
    "Publicidad" => { "pt-PT" => "Publicidade", "en" => "Advertising", "es" => "Publicidad" },
    "Storytelling Visual" => { "pt-PT" => "Storytelling Visual", "en" => "Visual Storytelling", "es" => "Storytelling Visual" },
    "Visual Storytelling" => { "pt-PT" => "Storytelling Visual", "en" => "Visual Storytelling", "es" => "Storytelling Visual" },
    "Estratégia de Campanha" => { "pt-PT" => "Estratégia de Campanha", "en" => "Campaign Strategy", "es" => "Estrategia de Campaña" },
    "Campaign Strategy" => { "pt-PT" => "Estratégia de Campanha", "en" => "Campaign Strategy", "es" => "Estrategia de Campaña" },
    "Estrategia de Campaña" => { "pt-PT" => "Estratégia de Campanha", "en" => "Campaign Strategy", "es" => "Estrategia de Campaña" },

    # Psychology, Education & Science
    "Psicologia Cognitiva" => { "pt-PT" => "Psicologia Cognitiva", "en" => "Cognitive Psychology", "es" => "Psicología Cognitiva" },
    "Cognitive Psychology" => { "pt-PT" => "Psicologia Cognitiva", "en" => "Cognitive Psychology", "es" => "Psicología Cognitiva" },
    "Psicología Cognitiva" => { "pt-PT" => "Psicologia Cognitiva", "en" => "Cognitive Psychology", "es" => "Psicología Cognitiva" },
    "Psicologia" => { "pt-PT" => "Psicologia", "en" => "Psychology", "es" => "Psicología" },
    "Psychology" => { "pt-PT" => "Psicologia", "en" => "Psychology", "es" => "Psicología" },
    "Psicología" => { "pt-PT" => "Psicologia", "en" => "Psychology", "es" => "Psicología" },
    "EdTech" => { "pt-PT" => "EdTech", "en" => "EdTech", "es" => "EdTech" },
    "Educação" => { "pt-PT" => "Educação", "en" => "Education", "es" => "Educación" },
    "Education" => { "pt-PT" => "Educação", "en" => "Education", "es" => "Educación" },
    "Educación" => { "pt-PT" => "Educação", "en" => "Education", "es" => "Educación" },
    "Engenharia" => { "pt-PT" => "Engenharia", "en" => "Engineering", "es" => "Ingeniería" },
    "Engineering" => { "pt-PT" => "Engenharia", "en" => "Engineering", "es" => "Ingeniería" },
    "Ingeniería" => { "pt-PT" => "Engenharia", "en" => "Engineering", "es" => "Ingeniería" }
  }.freeze

  def project_main_category(project)
    loc = current_locale_key
    raw_cat = project.role.presence

    if raw_cat.blank? && project.tags.present?
      first_tag = project.tags.split(",").first&.strip
      raw_cat = first_tag if first_tag.present?
    end

    return "" if raw_cat.blank?

    CATEGORY_TRANSLATIONS.dig(raw_cat, loc) ||
      TAG_TRANSLATIONS.dig(raw_cat, loc) ||
      raw_cat
  end

  def translate_tag(tag)
    return "" if tag.blank?
    loc = current_locale_key
    clean_tag = tag.strip
    TAG_TRANSLATIONS.dig(clean_tag, loc) ||
      CATEGORY_TRANSLATIONS.dig(clean_tag, loc) ||
      clean_tag
  end

  def project_filter_keys(project)
    raw = [ project.role, project.tags, project_main_category(project) ].compact.join(" ").downcase
    keys = [ "all" ]
    keys << "pd" if raw.include?("product") || raw.include?("produto") || raw.include?("diseño de producto")
    keys << "ui_ux" if raw.include?("ui") || raw.include?("ux") || raw.include?("interação") || raw.include?("interaccion") || raw.include?("interaction")
    keys << "brand" if raw.include?("brand") || raw.include?("marca") || raw.include?("identidade") || raw.include?("identidad")
    keys << "graphic" if raw.include?("graphic") || raw.include?("gráfico") || raw.include?("grafico") || raw.include?("editorial") || raw.include?("impressos") || raw.include?("print") || raw.include?("información") || raw.include?("informação")
    keys << "ecommerce" if raw.include?("commerce") || raw.include?("comércio") || raw.include?("comercio") || raw.include?("loja") || raw.include?("packaging")
    keys.uniq.join(" ")
  end

  def display_period(raw_period)
    return "" if raw_period.blank?

    loc = current_locale_key
    str = raw_period.to_s.strip

    # Mapear strings como "27 de setembro de 2023" ou "28 de julho de 2024"
    if str =~ /(\d{1,2})\s+de\s+([a-zA-ZçÇãÃ]+)\s+de\s+(\d{4})/i
      day = Regexp.last_match(1)
      month_raw = Regexp.last_match(2).downcase
      year = Regexp.last_match(3)

      months = {
        "janeiro" => { "pt-PT" => "Jan", "en" => "Jan", "es" => "Ene" },
        "fevereiro" => { "pt-PT" => "Fev", "en" => "Feb", "es" => "Feb" },
        "março" => { "pt-PT" => "Mar", "en" => "Mar", "es" => "Mar" },
        "abril" => { "pt-PT" => "Abr", "en" => "Apr", "es" => "Abr" },
        "maio" => { "pt-PT" => "Mai", "en" => "May", "es" => "May" },
        "junho" => { "pt-PT" => "Jun", "en" => "Jun", "es" => "Jun" },
        "julho" => { "pt-PT" => "Jul", "en" => "Jul", "es" => "Jul" },
        "agosto" => { "pt-PT" => "Ago", "en" => "Aug", "es" => "Ago" },
        "setembro" => { "pt-PT" => "Set", "en" => "Sep", "es" => "Sep" },
        "outubro" => { "pt-PT" => "Out", "en" => "Oct", "es" => "Oct" },
        "novembro" => { "pt-PT" => "Nov", "en" => "Nov", "es" => "Nov" },
        "dezembro" => { "pt-PT" => "Dez", "en" => "Dec", "es" => "Dic" }
      }

      short_month = months.dig(month_raw, loc) || month_raw.capitalize.first(3)
      return "#{short_month} #{year}"
    end

    str
  end

  private

  def current_locale_key
    loc = I18n.locale.to_s
    return "pt-PT" if loc.start_with?("pt")
    return "es" if loc.start_with?("es")
    "en"
  end
end
