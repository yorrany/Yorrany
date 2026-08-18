# db/seeds_portfolio_translations.rb
puts "Iniciando atualização e tradução dos CaseStudies..."

case_study_data = {
  1 => {
    'pt-PT' => {
      title: "Cubos Academy",
      role: "UI/UX Design",
      period: "Set 2023",
      tagline: "Plataforma Educacional de Tecnologia & Design",
      summary: "Desenho da experiência de utilizador e interface da plataforma de ensino da Cubos Academy, focada em retenção e clareza no processo de aprendizagem.",
      client: "Cubos Academy",
      tags: "UI/UX Design, Design de Interações, Direção de Arte, Figma, EdTech"
    },
    'en' => {
      title: "Cubos Academy",
      role: "UI/UX Design",
      period: "Sep 2023",
      tagline: "EdTech Learning & Design Platform",
      summary: "End-to-end user experience and UI design for Cubos Academy's educational platform, focusing on student retention and learning flow clarity.",
      client: "Cubos Academy",
      tags: "UI/UX Design, Interaction Design, Art Direction, Figma, EdTech"
    },
    'es' => {
      title: "Cubos Academy",
      role: "Diseño UI/UX",
      period: "Sep 2023",
      tagline: "Plataforma Educativa de Tecnología y Diseño",
      summary: "Diseño de experiencia de usuario e interfaz de la plataforma educativa de Cubos Academy, centrada en retención y claridad en el aprendizaje.",
      client: "Cubos Academy",
      tags: "Diseño UI/UX, Diseño de Interacción, Dirección de Arte, Figma, EdTech"
    }
  },
  2 => {
    'pt-PT' => {
      title: "Kayo Paladino",
      role: "Product Design",
      period: "Jul 2024",
      tagline: "Mobile App & Identidade de Marca Pessoal",
      summary: "Conceção do produto digital mobile e estratégia de posicionamento de marca, integrando ergonomia visual e arquitetura de fluxos.",
      client: "Kayo Paladino",
      tags: "Product Design, Mobile App, UI/UX Design, Figma, Branding"
    },
    'en' => {
      title: "Kayo Paladino",
      role: "Product Design",
      period: "Jul 2024",
      tagline: "Mobile App & Personal Brand Identity",
      summary: "Digital mobile product conception and brand positioning strategy, integrating visual ergonomics and intuitive UX flows.",
      client: "Kayo Paladino",
      tags: "Product Design, Mobile App, UI/UX Design, Figma, Branding"
    },
    'es' => {
      title: "Kayo Paladino",
      role: "Diseño de Producto",
      period: "Jul 2024",
      tagline: "App Móvil e Identidad de Marca Personal",
      summary: "Concepción de producto digital móvil y estrategia de posicionamiento de marca, combinando ergonomía visual y flujos intuitivos.",
      client: "Kayo Paladino",
      tags: "Diseño de Producto, App Móvil, Diseño UI/UX, Figma, Branding"
    }
  },
  3 => {
    'pt-PT' => {
      title: "Tecnorádio",
      role: "Design Gráfico",
      period: "Jul 2024",
      tagline: "Comunicação Visual & Estratégia de Conteúdo",
      summary: "Desenvolvimento de identidade de comunicação e estratégia gráfica para múltiplos canais digitais e impressos.",
      client: "Tecnorádio",
      tags: "Design Gráfico, Estratégia Digital, Social Media, Publicidade"
    },
    'en' => {
      title: "Tecnorádio",
      role: "Graphic Design",
      period: "Jul 2024",
      tagline: "Visual Communication & Content Strategy",
      summary: "Development of comprehensive visual communication and design strategy across digital and offline media channels.",
      client: "Tecnorádio",
      tags: "Graphic Design, Digital Strategy, Social Media, Advertising"
    },
    'es' => {
      title: "Tecnorádio",
      role: "Diseño Gráfico",
      period: "Jul 2024",
      tagline: "Comunicación Visual y Estrategia de Contenido",
      summary: "Desarrollo de comunicación visual integral y estrategia de diseño para canales digitales y tradicionales.",
      client: "Tecnorádio",
      tags: "Diseño Gráfico, Estrategia Digital, Redes Sociales, Publicidad"
    }
  },
  4 => {
    'pt-PT' => {
      title: "Gráfica Vitória",
      role: "Design Gráfico",
      period: "Jul 2024",
      tagline: "Design Gráfico Editorial & Campanhas Institucionais",
      summary: "Direção de arte e projetos gráficos de grande formato e editoriais para campanhas de alto alcance e impacto institucional.",
      client: "Gráfica Vitória",
      tags: "Design Gráfico, Print, Branding, Editorial"
    },
    'en' => {
      title: "Gráfica Vitória",
      role: "Graphic Design",
      period: "Jul 2024",
      tagline: "Editorial Graphic Design & Institutional Campaigns",
      summary: "Art direction and large-format editorial graphic projects for high-reach institutional campaigns.",
      client: "Gráfica Vitória",
      tags: "Graphic Design, Print, Branding, Editorial"
    },
    'es' => {
      title: "Gráfica Vitória",
      role: "Diseño Gráfico",
      period: "Jul 2024",
      tagline: "Diseño Gráfico Editorial y Campañas Institucionales",
      summary: "Dirección de arte y proyectos gráficos de gran formato y editoriales para campañas institucionales.",
      client: "Gráfica Vitória",
      tags: "Diseño Gráfico, Impresión, Branding, Editorial"
    }
  },
  5 => {
    'pt-PT' => {
      title: "Adriana Nunes",
      role: "Estratégia de Marca",
      period: "Set 2024",
      tagline: "Branding & Identidade Visual de Alto Padrão",
      summary: "Construção de ecossistema de marca com foco em sofisticação, tipografia refinada e consistência em todos os pontos de contacto.",
      client: "Adriana Nunes",
      tags: "Estratégia de Marca, Branding, Design Gráfico, Tipografia"
    },
    'en' => {
      title: "Adriana Nunes",
      role: "Brand Strategy",
      period: "Sep 2024",
      tagline: "High-End Branding & Visual Identity",
      summary: "Brand ecosystem development focusing on sophistication, refined typography, and touchpoint consistency.",
      client: "Adriana Nunes",
      tags: "Brand Strategy, Branding, Graphic Design, Typography"
    },
    'es' => {
      title: "Adriana Nunes",
      role: "Estrategia de Marca",
      period: "Sep 2024",
      tagline: "Branding e Identidad Visual de Alto Nivel",
      summary: "Construcción de ecosistema de marca con enfoque en sofisticación, tipografía refinada y coherencia visual.",
      client: "Adriana Nunes",
      tags: "Estrategia de Marca, Branding, Diseño Gráfico, Tipografía"
    }
  },
  6 => {
    'pt-PT' => {
      title: "LadyBee",
      role: "E-Commerce",
      period: "Mai 2025",
      tagline: "Identidade de Marca & Experiência Digital Gastronómica",
      summary: "Projeto integrado de branding e arquitetura de e-commerce gastronómico com navegação sensorial e alta conversão.",
      client: "LadyBee Doceria",
      tags: "E-Commerce, Branding, Web Design, Design Gráfico"
    },
    'en' => {
      title: "LadyBee",
      role: "E-Commerce",
      period: "May 2025",
      tagline: "Brand Identity & Culinary Digital Experience",
      summary: "Integrated branding and e-commerce digital experience design for high-conversion culinary retail.",
      client: "LadyBee Confectionery",
      tags: "E-Commerce, Branding, Web Design, Graphic Design"
    },
    'es' => {
      title: "LadyBee",
      role: "E-Commerce",
      period: "May 2025",
      tagline: "Identidad de Marca y Experiencia Digital Gastronómica",
      summary: "Proyecto integral de branding y arquitectura de comercio electrónico gastronómico con navegación sensorial y alta conversión.",
      client: "LadyBee Pastelería",
      tags: "Comercio Electrónico, Branding, Diseño Web, Diseño Gráfico"
    }
  },
  7 => {
    'pt-PT' => {
      title: "Yorrany",
      role: "Estratégia de Marca",
      period: "Mai 2025",
      tagline: "Identidade Visual Autoral & Sistema Tipográfico",
      summary: "Identidade visual própria com síntese geométrica, rigor estrutural suíço e arquitetura modular de marca.",
      client: "Yorrany Braga",
      tags: "Estratégia de Marca, Branding, Design Gráfico, Identidade Visual"
    },
    'en' => {
      title: "Yorrany",
      role: "Brand Strategy",
      period: "May 2025",
      tagline: "Authorial Visual Identity & Typographic System",
      summary: "Authorial personal brand system combining geometric precision, Swiss modernist typography, and modular design.",
      client: "Yorrany Braga",
      tags: "Brand Strategy, Branding, Graphic Design, Visual Identity"
    },
    'es' => {
      title: "Yorrany",
      role: "Estrategia de Marca",
      period: "May 2025",
      tagline: "Identidad Visual Autoral y Sistema Tipográfico",
      summary: "Identidad visual propia con síntesis geométrica, rigor suizo y arquitectura modular de marca.",
      client: "Yorrany Braga",
      tags: "Estrategia de Marca, Branding, Diseño Gráfico, Identidad Visual"
    }
  },
  8 => {
    'pt-PT' => {
      title: "Jungle Nutri",
      role: "Estratégia de Marca",
      period: "Jul 2025",
      tagline: "Identidade de Marca & Embalagens para Nutrição",
      summary: "Design de embalagens e arquitetura de marca para produtos de nutrição sustentável originários da Amazónia.",
      client: "Jungle Nutri",
      tags: "Estratégia de Marca, Design de Logotipo, Packaging, Design Gráfico"
    },
    'en' => {
      title: "Jungle Nutri",
      role: "Brand Strategy",
      period: "Jul 2025",
      tagline: "Brand Identity & Sustainable Nutrition Packaging",
      summary: "Packaging system and brand architecture for Amazonian sustainable health and nutrition products.",
      client: "Jungle Nutri",
      tags: "Brand Strategy, Logo Design, Packaging, Graphic Design"
    },
    'es' => {
      title: "Jungle Nutri",
      role: "Estrategia de Marca",
      period: "Jul 2025",
      tagline: "Identidad de Marca y Empaques para Nutrición",
      summary: "Diseño de packaging y arquitectura de marca para productos de nutrición sostenible de la Amazonia.",
      client: "Jungle Nutri",
      tags: "Estrategia de Marca, Diseño de Logotipo, Packaging, Diseño Gráfico"
    }
  },
  9 => {
    'pt-PT' => {
      title: "Geostrauss",
      role: "Estratégia Digital",
      period: "Ago 2024",
      tagline: "Estratégia de Conteúdo Visual & Motion Design",
      summary: "Criação de identidade audiovisual e peças dinâmicas de engenharia e geotecnia para autoridade digital.",
      client: "Geostrauss Engenharia",
      tags: "Estratégia Digital, Motion Design, Social Media, Design Gráfico"
    },
    'en' => {
      title: "Geostrauss",
      role: "Digital Strategist",
      period: "Aug 2024",
      tagline: "Visual Content Strategy & Motion Design",
      summary: "Dynamic audiovisual content system and motion design for geotechnical engineering authority.",
      client: "Geostrauss Engineering",
      tags: "Digital Strategist, Motion Design, Social Media, Graphic Design"
    },
    'es' => {
      title: "Geostrauss",
      role: "Estrategia Digital",
      period: "Ago 2024",
      tagline: "Estrategia de Contenido Visual y Motion Design",
      summary: "Creación de identidad audiovisual y piezas de ingeniería y geotecnia para autoridad digital.",
      client: "Geostrauss Ingeniería",
      tags: "Estrategia Digital, Motion Design, Redes Sociales, Diseño Gráfico"
    }
  },
  10 => {
    'pt-PT' => {
      title: "CogniBox",
      role: "Product Design",
      period: "Jul 2024",
      tagline: "E-Commerce & Ferramentas para Psicopedagogia",
      summary: "Plataforma de comércio digital e materiais educativos integrando psicologia cognitiva e design centrado no utilizador.",
      client: "CogniBox Educação",
      tags: "Product Design, E-Commerce, UI/UX Design, Branding, Psicologia"
    },
    'en' => {
      title: "CogniBox",
      role: "Product Design",
      period: "Jul 2024",
      tagline: "E-Commerce & Cognitive Tools Platform",
      summary: "Digital commerce platform and educational products blending cognitive psychology with user-centered design.",
      client: "CogniBox Education",
      tags: "Product Design, E-Commerce, UI/UX Design, Branding, Psychology"
    },
    'es' => {
      title: "CogniBox",
      role: "Diseño de Producto",
      period: "Jul 2024",
      tagline: "Comercio Electrónico y Herramientas Cognitivas",
      summary: "Plataforma de comercio electrónico y materiales educativos que integran psicología cognitiva y diseño centrado en el usuario.",
      client: "CogniBox Educación",
      tags: "Diseño de Producto, Comercio Electrónico, Diseño UI/UX, Branding, Psicología"
    }
  },
  11 => {
    'pt-PT' => {
      title: "Dra. Priscilla Lima",
      role: "Estratégia de Marca",
      period: "Jan 2024",
      tagline: "Posicionamento de Marca & Identidade Visual Médica",
      summary: "Identidade visual para consultório médico de alta reputação, equilibrando empatia humana e rigor científico.",
      client: "Dra. Priscilla Lima",
      tags: "Estratégia de Marca, Branding, Design Gráfico, Identidade Visual"
    },
    'en' => {
      title: "Dra. Priscilla Lima",
      role: "Brand Strategy",
      period: "Jan 2024",
      tagline: "Medical Visual Identity & Brand Positioning",
      summary: "Premium visual identity for a specialized medical clinic, harmonizing human empathy with scientific precision.",
      client: "Dra. Priscilla Lima",
      tags: "Brand Strategy, Branding, Graphic Design, Visual Identity"
    },
    'es' => {
      title: "Dra. Priscilla Lima",
      role: "Estrategia de Marca",
      period: "Ene 2024",
      tagline: "Identidad Visual Médica y Posicionamiento de Marca",
      summary: "Identidad visual para consultorio médico de alta reputación, combinando empatía humana y rigor científico.",
      client: "Dra. Priscilla Lima",
      tags: "Estrategia de Marca, Branding, Diseño Gráfico, Identidad Visual"
    }
  },
  12 => {
    'pt-PT' => {
      title: "Itam",
      role: "Estratégia Digital",
      period: "Jul 2024",
      tagline: "Comunicação Digital & Estratégia de Redes Sociais",
      summary: "Sistema de peças e planeamento de comunicação digital para engajamento comunitário e expansão institucional.",
      client: "Instituto ITAM",
      tags: "Estratégia Digital, Social Media, Design Gráfico, Marketing"
    },
    'en' => {
      title: "Itam",
      role: "Digital Strategist",
      period: "Jul 2024",
      tagline: "Digital Communication & Social Strategy",
      summary: "Digital content design and multi-channel communication strategy for community engagement and reach.",
      client: "ITAM Institute",
      tags: "Digital Strategist, Social Media, Graphic Design, Marketing"
    },
    'es' => {
      title: "Itam",
      role: "Estrategia Digital",
      period: "Jul 2024",
      tagline: "Comunicación Digital y Estrategia de Redes Sociales",
      summary: "Diseño de contenido digital y estrategia de comunicación para engagement comunitario y alcance institucional.",
      client: "Instituto ITAM",
      tags: "Estrategia Digital, Redes Sociales, Diseño Gráfico, Marketing"
    }
  },
  13 => {
    'pt-PT' => {
      title: "Grid Comercial",
      role: "Design Gráfico",
      period: "Jul 2024",
      tagline: "Design de Informação & Peças Corporativas",
      summary: "Estruturação de materiais gráficos de planeamento comercial e grelhas de dados para suporte corporativo.",
      client: "Grid Comercial",
      tags: "Design Gráfico, Figma, Design Editorial, Tipografia"
    },
    'en' => {
      title: "Grid Comercial",
      role: "Graphic Design",
      period: "Jul 2024",
      tagline: "Information Design & Corporate Collateral",
      summary: "Information architecture and print design systems for corporate sales planning and productivity tools.",
      client: "Grid Comercial",
      tags: "Graphic Design, Figma, Editorial Design, Typography"
    },
    'es' => {
      title: "Grid Comercial",
      role: "Diseño Gráfico",
      period: "Jul 2024",
      tagline: "Diseño de Información y Materiales Corporativos",
      summary: "Estructuración de piezas gráficas de planificación comercial y retículas de datos para soporte corporativo.",
      client: "Grid Comercial",
      tags: "Diseño Gráfico, Figma, Diseño Editorial, Tipografía"
    }
  },
  14 => {
    'pt-PT' => {
      title: "Espaço Caboquinho",
      role: "Estratégia de Marca",
      period: "Ago 2024",
      tagline: "Identidade de Marca Regional & Marketing Visual",
      summary: "Reposicionamento de marca e direção visual valorizando a cultura local com linguagem contemporânea.",
      client: "Espaço Caboquinho",
      tags: "Estratégia de Marca, Branding, Social Media, Design Gráfico"
    },
    'en' => {
      title: "Espaço Caboquinho",
      role: "Brand Strategy",
      period: "Aug 2024",
      tagline: "Regional Brand Identity & Visual Marketing",
      summary: "Brand repositioning and visual direction celebrating local cultural heritage through contemporary design.",
      client: "Espaço Caboquinho",
      tags: "Brand Strategy, Branding, Social Media, Graphic Design"
    },
    'es' => {
      title: "Espaço Caboquinho",
      role: "Estrategia de Marca",
      period: "Ago 2024",
      tagline: "Identidad de Marca Regional y Marketing Visual",
      summary: "Reposicionamiento de marca y dirección visual celebrando la cultura local con lenguaje contemporáneo.",
      client: "Espaço Caboquinho",
      tags: "Estrategia de Marca, Branding, Redes Sociales, Diseño Gráfico"
    }
  },
  15 => {
    'pt-PT' => {
      title: "Diversos",
      role: "Design Gráfico",
      period: "Jul 2021",
      tagline: "Coleção de Peças Gráficas & Impressos Promocionais",
      summary: "Acervo de direção de arte, posters, flyers e materiais promocionais com exploração tipográfica e cromática.",
      client: "Clientes Diversos",
      tags: "Design Gráfico, Print, Flyer, Direção de Arte"
    },
    'en' => {
      title: "Diversos",
      role: "Graphic Design",
      period: "Jul 2021",
      tagline: "Print Design & Promotional Artwork Collection",
      summary: "Curated collection of art direction, posters, and print collateral exploring typography and color theory.",
      client: "Various Clients",
      tags: "Graphic Design, Print, Flyer, Art Direction"
    },
    'es' => {
      title: "Diversos",
      role: "Diseño Gráfico",
      period: "Jul 2021",
      tagline: "Colección de Piezas Gráficas e Impresos Promocionales",
      summary: "Colección de dirección de arte, carteles y materiales impresos explorando tipografía y teoría del color.",
      client: "Varios Clientes",
      tags: "Diseño Gráfico, Impresión, Flyer, Dirección de Arte"
    }
  },
  16 => {
    'pt-PT' => {
      title: "Tupinside",
      role: "Publicidade",
      period: "Set 2024",
      tagline: "Campanha Publicitária & Identidade Visual Criativa",
      summary: "Criação de campanha publicitária com storytelling visual e direção de arte para alto impacto de marca.",
      client: "Tupinside",
      tags: "Publicidade, Design Gráfico, Branding, Criatividade"
    },
    'en' => {
      title: "Tupinside",
      role: "Advertising",
      period: "Sep 2024",
      tagline: "Creative Advertising Campaign & Visual Identity",
      summary: "Advertising campaign creation with visual storytelling and striking art direction for maximum brand resonance.",
      client: "Tupinside",
      tags: "Advertising, Graphic Design, Branding, Creativity"
    },
    'es' => {
      title: "Tupinside",
      role: "Publicidad",
      period: "Sep 2024",
      tagline: "Campaña Publicitaria e Identidad Visual Creativa",
      summary: "Creación de campaña publicitaria con narrativa visual y dirección de arte para alto impacto de marca.",
      client: "Tupinside",
      tags: "Publicidad, Diseño Gráfico, Branding, Creatividad"
    }
  }
}

case_study_data.each do |id, translations|
  cs = CaseStudy.find_by(id: id)
  next unless cs

  cs.skip_auto_translate = true
  cs.is_spotlight = (id == 1)

  translations.each do |locale_key, attrs|
    Mobility.with_locale(locale_key.to_sym) do
      attrs.each do |k, v|
        cs.public_send("#{k}=", v)
      end
    end
  end

  cs.save!
  puts "CaseStudy #{id} (#{translations['pt-PT'][:title]}) traduzido e salvo com sucesso!"
end

# Atualização de ExperienceItems
exp_type_names = {
  1 => { 'pt-PT' => "Tempo Integral", 'en' => "Full-time", 'es' => "Tiempo Completo" },
  2 => { 'pt-PT' => "Tempo Integral", 'en' => "Full-time", 'es' => "Tiempo Completo" },
  3 => { 'pt-PT' => "Tempo Integral", 'en' => "Full-time", 'es' => "Tiempo Completo" },
  4 => { 'pt-PT' => "Académico", 'en' => "Academic", 'es' => "Académico" },
  5 => { 'pt-PT' => "Estágio", 'en' => "Internship", 'es' => "Prácticas" },
  6 => { 'pt-PT' => "Tempo Integral", 'en' => "Full-time", 'es' => "Tiempo Completo" },
  7 => { 'pt-PT' => "Tempo Integral", 'en' => "Full-time", 'es' => "Tiempo Completo" }
}

exp_type_names.each do |id, types|
  exp = ExperienceItem.find_by(id: id)
  next unless exp
  exp.skip_auto_translate = true
  types.each do |loc, val|
    Mobility.with_locale(loc.to_sym) do
      exp.type_name = val
    end
  end
  exp.save!
end

puts "Atualização completa realizada com sucesso!"
