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
    "Interface e exp. do usuário" => { "pt-PT" => "UI/UX Design", "en" => "UI/UX Design", "es" => "Diseño UI/UX" },
    "Estratégia de Marca" => { "pt-PT" => "Estratégia de Marca", "en" => "Brand Strategy", "es" => "Estrategia de Marca" },
    "Brand Strategy" => { "pt-PT" => "Estratégia de Marca", "en" => "Brand Strategy", "es" => "Estrategia de Marca" },
    "Estrategia de Marca" => { "pt-PT" => "Estratégia de Marca", "en" => "Brand Strategy", "es" => "Estrategia de Marca" },
    "Branding" => { "pt-PT" => "Branding", "en" => "Branding", "es" => "Branding" },
    "Estratégia Digital" => { "pt-PT" => "Estratégia Digital", "en" => "Digital Strategist", "es" => "Estrategia Digital" },
    "Digital Strategist" => { "pt-PT" => "Estratégia Digital", "en" => "Digital Strategist", "es" => "Estrategia Digital" },
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
    "Design de interações" => { "pt-PT" => "Design de Interações", "en" => "Interaction Design", "es" => "Diseño de Interacción" },
    "Direção artística" => { "pt-PT" => "Direção de Arte", "en" => "Art Direction", "es" => "Dirección de Arte" },
    "Interface e exp. do usuário" => { "pt-PT" => "UI/UX Design", "en" => "UI/UX Design", "es" => "Diseño UI/UX" },
    "Design gráfico" => { "pt-PT" => "Design Gráfico", "en" => "Graphic Design", "es" => "Diseño Gráfico" },
    "app design" => { "pt-PT" => "App Design", "en" => "App Design", "es" => "Diseño de Apps" },
    "Mobile app" => { "pt-PT" => "App Mobile", "en" => "Mobile App", "es" => "App Móvil" },
    "Social media post" => { "pt-PT" => "Social Media", "en" => "Social Media", "es" => "Redes Sociales" },
    "Socialmedia" => { "pt-PT" => "Social Media", "en" => "Social Media", "es" => "Redes Sociales" },
    "Graphic Designer" => { "pt-PT" => "Design Gráfico", "en" => "Graphic Design", "es" => "Diseño Gráfico" },
    "design" => { "pt-PT" => "Design", "en" => "Design", "es" => "Diseño" },
    "marketing" => { "pt-PT" => "Marketing", "en" => "Marketing", "es" => "Marketing" },
    "Marca" => { "pt-PT" => "Marca", "en" => "Brand Identity", "es" => "Identidad de Marca" },
    "Design de logotipo" => { "pt-PT" => "Design de Logotipo", "en" => "Logo Design", "es" => "Diseño de Logotipo" },
    "Logo Design" => { "pt-PT" => "Design de Logotipo", "en" => "Logo Design", "es" => "Diseño de Logotipo" },
    "identidade visual" => { "pt-PT" => "Identidade Visual", "en" => "Visual Identity", "es" => "Identidad Visual" },
    "visual identity" => { "pt-PT" => "Identidade Visual", "en" => "Visual Identity", "es" => "Identidad Visual" },
    "brand identity" => { "pt-PT" => "Identidade de Marca", "en" => "Brand Identity", "es" => "Identidad de Marca" },
    "motion design" => { "pt-PT" => "Motion Design", "en" => "Motion Design", "es" => "Motion Design" },
    "psicologia" => { "pt-PT" => "Psicologia", "en" => "Psychology", "es" => "Psicología" },
    "educação" => { "pt-PT" => "Educação", "en" => "Education", "es" => "Educación" },
    "learning app" => { "pt-PT" => "EdTech", "en" => "EdTech", "es" => "EdTech" }
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
