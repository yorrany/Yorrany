# frozen_string_literal: true

def run_full_sync!
  puts "Iniciando sincronização profunda de todas as traduções (Experiências, Educação, Certificações)..."

  # =========================================================================
  # 1. EXPERIÊNCIAS
  # =========================================================================
  ExperienceItem.order(id: :asc).each do |e|
    e.skip_auto_translate = true
    case e.id
    when 1
      Mobility.with_locale(:"pt-PT") do
        e.role = "Senior Product Designer & Front-End Architect"
        e.company = "Matterna"
        e.period = "Dez 2024 - Atual"
        e.location = "Remoto • São Paulo, Brasil"
        e.summary = "Liderança de ponta a ponta em design de produto, governança de design systems e arquitetura front-end para plataforma digital de saúde materno-infantil."
        e.highlights = "Projeto autoral focado em inovação de produto e validação completa de processos de design do zero ao um."
        e.skills = "Design UX/UI, Branding, Estratégia de Produto, E-commerce, Design Systems"
      end
      Mobility.with_locale(:en) do
        e.role = "Senior Product Designer & Front-End Architect"
        e.company = "Matterna"
        e.period = "Dec 2024 - Present"
        e.location = "Remote • São Paulo, Brazil"
        e.summary = "End-to-end product design leadership, design system governance, and front-end architecture for digital maternal health platform."
        e.highlights = "Authorial project focused on product innovation and validation of end-to-end design processes from zero to one."
        e.skills = "UX/UI Design, Branding, Product Strategy, E-commerce, Design Systems"
      end
      Mobility.with_locale(:es) do
        e.role = "Diseñador de Producto Senior & Front-End Architect"
        e.company = "Matterna"
        e.period = "Dic 2024 - Actualidad"
        e.location = "Remoto • São Paulo, Brasil"
        e.summary = "Liderazgo integral en diseño de producto, gobernanza de design systems y arquitectura front-end para plataforma digital de salud materno-infantil."
        e.highlights = "Proyecto autoral centrado en la innovación de producto y validación integral de procesos de diseño de cero a uno."
        e.skills = "Diseño UX/UI, Branding, Estrategia de Producto, E-commerce, Design Systems"
      end
    when 2
      Mobility.with_locale(:"pt-PT") do
        e.role = "Diretor de Arte"
        e.company = "Agência Taió"
        e.period = "Fev 2022 - Out 2023"
        e.location = "São José dos Campos, Brasil"
        e.summary = "Desenvolvimento de projetos de comunicação visual, design gráfico e branding para clientes de renome nacional. Criação de peças focadas no aumento de conversão e fortalecimento de marca."
        e.highlights = "Campanhas de reposicionamento de marca e identidade visual."
        e.skills = "Direção de Arte, Design Gráfico, Branding"
      end
      Mobility.with_locale(:en) do
        e.role = "Art Director"
        e.company = "Agência Taió"
        e.period = "Feb 2022 - Oct 2023"
        e.location = "São José dos Campos, Brazil"
        e.summary = "Development of visual communication projects, graphic design, and branding for nationally renowned clients. Creation of assets focused on increasing conversion rates and brand recognition."
        e.highlights = "Brand repositioning and visual identity campaigns."
        e.skills = "Art Direction, Graphic Design, Branding"
      end
      Mobility.with_locale(:es) do
        e.role = "Director de Arte"
        e.company = "Agência Taió"
        e.period = "Feb 2022 - Oct 2023"
        e.location = "São José dos Campos, Brasil"
        e.summary = "Desarrollo de proyectos de comunicación visual, diseño gráfico y branding para clientes de renombre nacional. Creación de piezas enfocadas en aumentar la conversión y fortalecer la marca."
        e.highlights = "Campañas de reposicionamiento de marca e identidad visual."
        e.skills = "Dirección de Arte, Diseño Gráfico, Branding"
      end
    when 3
      Mobility.with_locale(:"pt-PT") do
        e.role = "Diretor de Arte"
        e.company = "BZ Propaganda & Marketing"
        e.period = "Dez 2021 - Abr 2022"
        e.location = "São José dos Campos, Brasil"
        e.summary = "Criação e execução de campanhas publicitárias online e offline para grandes clientes, como o Grupo Saboroso. Direção de arte e estratégias visuais focadas em posicionamento de mercado."
        e.highlights = "Campanhas publicitárias de alto impacto e performance."
        e.skills = "Publicidade, Direção de Arte, Marketing Online/Offline"
      end
      Mobility.with_locale(:en) do
        e.role = "Art Director"
        e.company = "BZ Propaganda & Marketing"
        e.period = "Dec 2021 - Apr 2022"
        e.location = "São José dos Campos, Brazil"
        e.summary = "Creation and execution of online and offline advertising campaigns for large clients, such as Grupo Saboroso. Art direction and visual strategies focused on market positioning."
        e.highlights = "High-impact advertising and performance campaigns."
        e.skills = "Advertising, Art Direction, Online/Offline Marketing"
      end
      Mobility.with_locale(:es) do
        e.role = "Director de Arte"
        e.company = "BZ Propaganda & Marketing"
        e.period = "Dic 2021 - Abr 2022"
        e.location = "São José dos Campos, Brasil"
        e.summary = "Creación y ejecución de campañas publicitarias online y offline para grandes clientes, como Grupo Saboroso. Dirección de arte y estrategias visuales enfocadas en posicionamiento de mercado."
        e.highlights = "Campañas publicitarias de alto impacto y rendimiento."
        e.skills = "Publicidad, Dirección de Arte, Marketing Online/Offline"
      end
    when 4
      Mobility.with_locale(:"pt-PT") do
        e.role = "Pesquisador Académico"
        e.company = "ULBRA - Universidade Luterana do Brasil"
        e.period = "Mai 2021 - Out 2021"
        e.location = "Manaus, Brasil"
        e.summary = "Pesquisa científica e redação do Capítulo V (pp. 53-66) do livro 'Educação em Saúde: gravidez na adolescência, bullying, prevenção de acidentes, envelhecimento e bem-estar na Amazônia'. Análise psicossocial e elaboração de diagnósticos sobre os impactos da gravidez precoce."
        e.highlights = "Capítulo de livro publicado e aprovado por comitê científico."
        e.skills = "Pesquisa Académica, Análise Psicossocial, Redação Científica"
      end
      Mobility.with_locale(:en) do
        e.role = "Academic Researcher"
        e.company = "ULBRA - Universidade Luterana do Brasil"
        e.period = "May 2021 - Oct 2021"
        e.location = "Manaus, Brazil"
        e.summary = "Scientific research and writing of Chapter V (pp. 53-66) of the book 'Health Education: teenage pregnancy, bullying, accident prevention, aging, and well-being in the Amazon'. Psychosocial analysis and preparation of diagnoses on the impacts of early pregnancy."
        e.highlights = "Published book chapter approved by scientific committee."
        e.skills = "Academic Research, Psychosocial Analysis, Scientific Writing"
      end
      Mobility.with_locale(:es) do
        e.role = "Investigador Académico"
        e.company = "ULBRA - Universidade Luterana do Brasil"
        e.period = "May 2021 - Oct 2021"
        e.location = "Manaus, Brasil"
        e.summary = "Investigación científica y redacción del Capítulo V (pp. 53-66) del libro 'Educación en Salud: embarazo en la adolescencia, bullying, prevención de accidentes, envejecimiento y bienestar en la Amazonía'. Análisis psicosocial y elaboración de diagnósticos sobre los impactos del embarazo precoz."
        e.highlights = "Capítulo de libro publicado y aprobado por comité científico."
        e.skills = "Investigación Académica, Análisis Psicosocial, Redacción Científica"
      end
    when 5
      Mobility.with_locale(:"pt-PT") do
        e.role = "Assistente Universitário"
        e.company = "ULBRA - Universidade Luterana do Brasil"
        e.period = "Dez 2020 - Jun 2021"
        e.location = "Manaus, Brasil"
        e.summary = "Prática observacional e elaboração de diagnósticos em psicopatologia e psicologia comunitária (Carga horária: 76h)."
        e.highlights = "Prática clínica e intervenção em psicologia comunitária."
        e.skills = "Psicopatologia, Psicologia Comunitária, Observação Clínica"
      end
      Mobility.with_locale(:en) do
        e.role = "University Assistant"
        e.company = "ULBRA - Universidade Luterana do Brasil"
        e.period = "Dec 2020 - Jun 2021"
        e.location = "Manaus, Brazil"
        e.summary = "Observational practice and diagnostic assessment in psychopathology and community psychology (Workload: 76h)."
        e.highlights = "Clinical practice and community psychology intervention."
        e.skills = "Psychopathology, Community Psychology, Clinical Observation"
      end
      Mobility.with_locale(:es) do
        e.role = "Asistente Universitario"
        e.company = "ULBRA - Universidade Luterana do Brasil"
        e.period = "Dic 2020 - Jun 2021"
        e.location = "Manaus, Brasil"
        e.summary = "Práctica observacional y elaboración de diagnósticos en psicopatología y psicología comunitaria (Carga horaria: 76h)."
        e.highlights = "Práctica clínica e intervención en psicología comunitaria."
        e.skills = "Psicopatología, Psicología Comunitaria, Observación Clínica"
      end
    when 6
      Mobility.with_locale(:"pt-PT") do
        e.role = "Diretor de Arte"
        e.company = "All Night Pub"
        e.period = "Mai 2016 - Jun 2017"
        e.location = "Manaus, Brasil"
        e.summary = "Gestão da identidade visual da marca, criação de materiais institucionais, cardápios e peças promocionais. Gestão de redes sociais e planeamento visual de campanhas de eventos."
        e.highlights = "Branding para eventos de grande porte e gestão de redes sociais."
        e.skills = "Identidade de Marca, Design para Redes Sociais, Peças Promocionais"
      end
      Mobility.with_locale(:en) do
        e.role = "Art Director"
        e.company = "All Night Pub"
        e.period = "May 2016 - Jun 2017"
        e.location = "Manaus, Brazil"
        e.summary = "Brand visual identity management, creation of institutional materials, menus, and promotional assets. Social media management and visual campaign planning for events."
        e.highlights = "Large-scale event branding and social media management."
        e.skills = "Brand Identity, Social Media Design, Promotional Materials"
      end
      Mobility.with_locale(:es) do
        e.role = "Director de Arte"
        e.company = "All Night Pub"
        e.period = "May 2016 - Jun 2017"
        e.location = "Manaus, Brasil"
        e.summary = "Gestión de la identidad visual de la marca, creación de materiales institucionales, cartas y piezas promocionales. Gestión de redes sociales y planificación visual de campañas para eventos."
        e.highlights = "Branding para eventos de gran escala y gestión de redes sociales."
        e.skills = "Identidad de Marca, Diseño para Redes Sociales, Piezas Promocionales"
      end
    when 7
      Mobility.with_locale(:"pt-PT") do
        e.role = "Diretor de Arte"
        e.company = "Magic Publicidade"
        e.period = "Dez 2010 - Jan 2013"
        e.location = "Manaus, Brasil"
        e.summary = "Produção de materiais para campanhas on e offline, gestão de prazos e fluxo de trabalho da equipa criativa."
        e.highlights = "Coordenação de equipa criativa e entrega de campanhas integradas."
        e.skills = "Produção de Campanhas, Gestão de Fluxo, Direção de Arte"
      end
      Mobility.with_locale(:en) do
        e.role = "Art Director"
        e.company = "Magic Publicidade"
        e.period = "Dec 2010 - Jan 2013"
        e.location = "Manaus, Brazil"
        e.summary = "Production of materials for on/offline campaigns, management of deadlines and creative team workflow."
        e.highlights = "Creative team coordination and integrated campaign delivery."
        e.skills = "Campaign Production, Workflow Management, Art Direction"
      end
      Mobility.with_locale(:es) do
        e.role = "Director de Arte"
        e.company = "Magic Publicidade"
        e.period = "Dic 2010 - Ene 2013"
        e.location = "Manaus, Brasil"
        e.summary = "Producción de materiales para campañas on y offline, gestión de plazos y flujo de trabajo del equipo creativo."
        e.highlights = "Coordinación de equipo creativo y entrega de campañas integradas."
        e.skills = "Producción de Campañas, Gestión de Flujo, Dirección de Arte"
      end
    end
    e.save!
  end
  puts "✓ Todas as 7 experiências foram sincronizadas nos 3 idiomas."

  # =========================================================================
  # 2. FORMAÇÃO ACADÊMICA
  # =========================================================================
  AcademicBackground.order(id: :asc).each do |a|
    a.skip_auto_translate = true
    case a.id
    when 1
      Mobility.with_locale(:"pt-PT") do
        a.degree = "Licenciatura em Psicologia"
        a.institution = "Faculdade Santa Teresa"
        a.period = "Fev 2019 - Atual"
        a.field_of_study = "Psicologia Cognitiva e Comportamental aplicada a Produtos Digitais"
        a.thesis = "Fatores Psicossociais e Comportamentais na Adoção de Tecnologias"
        a.research_focus = "Formação abrangente em Ciências Humanas e Psicologia, com ênfase em Psicologia Organizacional, Psicologia Comunitária, Saúde Pública e Psicopatologia.||Atividades Principais: Pesquisa Científica (Coautoria do Capítulo V no livro 'Educação em Saúde') e Estágio em Psicopatologia (Processos grupais e saúde pública)."
      end
      Mobility.with_locale(:en) do
        a.degree = "B.Sc. in Psychology"
        a.institution = "Faculdade Santa Teresa"
        a.period = "Feb 2019 - Present"
        a.field_of_study = "Cognitive & Behavioral Psychology applied to Digital Products"
        a.thesis = "Psychosocial and Behavioral Factors in Technology Adoption"
        a.research_focus = "Comprehensive training in Humanities and Psychology, focusing on Organizational Psychology, Community Psychology, Public Health, and Psychopathology.||Key Activities: Scientific Research (Co-author of Chapter V in the book 'Health Education') and Psychopathology Internship (Group processes and public health)."
      end
      Mobility.with_locale(:es) do
        a.degree = "Licenciatura en Psicología"
        a.institution = "Faculdade Santa Teresa"
        a.period = "Feb 2019 - Actualidad"
        a.field_of_study = "Psicología Cognitiva y Conductual aplicada a Productos Digitales"
        a.thesis = "Factores Psicosociales y Conductuales en la Adopción de Tecnologías"
        a.research_focus = "Formación integral en Ciencias Humanas y Psicología, con énfasis en Psicología Organizacional, Psicología Comunitaria, Salud Pública y Psicopatología.||Actividades Principales: Investigación Científica (Coautoría del Capítulo V en el libro 'Educación en Salud') y Prácticas en Psicopatología (Procesos grupales y salud pública)."
      end
    when 2
      Mobility.with_locale(:"pt-PT") do
        a.degree = "Ensino Secundário / Médio Completo"
        a.institution = "Colégio Estadual Professor José Carlos de Almeida"
        a.period = "Jan 2005 - Dez 2006"
        a.field_of_study = "Formação Geral e Científica"
        a.thesis = ""
        a.research_focus = "Ensino secundário/médio geral e científico, com carga horária total de 3.200 horas.||Componentes curriculares principais: Língua Portuguesa, Matemática, Física, Química, Biologia, História, Geografia, Filosofia, Artes e Línguas Estrangeiras (Inglês e Espanhol)."
      end
      Mobility.with_locale(:en) do
        a.degree = "High School Diploma"
        a.institution = "Colégio Estadual Professor José Carlos de Almeida"
        a.period = "Jan 2005 - Dec 2006"
        a.field_of_study = "General and Scientific Education"
        a.thesis = ""
        a.research_focus = "General and scientific high school education, with a total workload of 3,200 hours.||Main curricular components: Portuguese Language, Mathematics, Physics, Chemistry, Biology, History, Geography, Philosophy, Art, and Foreign Languages (English and Spanish)."
      end
      Mobility.with_locale(:es) do
        a.degree = "Educación Secundaria Completa"
        a.institution = "Colégio Estadual Professor José Carlos de Almeida"
        a.period = "Ene 2005 - Dic 2006"
        a.field_of_study = "Formación General y Científica"
        a.thesis = ""
        a.research_focus = "Educación secundaria general y científica, con una carga horaria total de 3.200 horas.||Principales componentes curriculares: Lengua Portuguesa, Matemáticas, Física, Química, Biología, Historia, Geografía, Filosofía, Artes y Lenguas Extranjeras (Inglés y Español)."
      end
    end
    a.save!
  end
  puts "✓ Todas as formações acadêmicas foram sincronizadas nos 3 idiomas."

  # =========================================================================
  # 3. CERTIFICAÇÕES
  # =========================================================================
  Certification.order(id: :asc).each do |c|
    c.skip_auto_translate = true
    case c.id
    when 1
      Mobility.with_locale(:"pt-PT") do
        c.title = "Introdução à Segurança em JavaScript (LFS184)"
        c.issuer = "The Linux Foundation"
        c.category = "Segurança & Front-End"
        c.description = "Práticas essenciais de segurança para aplicações JavaScript/Node.js, prevenção de vulnerabilidades OWASP Top 10, XSS, SSRF e mitigação de riscos na cadeia de suprimentos de software."
        c.skills = "Segurança em JavaScript, Segurança em Node.js, OWASP Top 10, XSS, SSRF, Segurança de Aplicações Web"
      end
      Mobility.with_locale(:en) do
        c.title = "Introduction to JavaScript Security (LFS184)"
        c.issuer = "The Linux Foundation"
        c.category = "Security & Front-End"
        c.description = "Essential security practices for JavaScript/Node.js applications, OWASP Top 10 vulnerability prevention, XSS, SSRF, and software supply chain risk mitigation."
        c.skills = "JavaScript Security, Node.js Security, Web Application Security, OWASP Top 10, XSS, SSRF"
      end
      Mobility.with_locale(:es) do
        c.title = "Introducción a la Seguridad de JavaScript (LFS184)"
        c.issuer = "The Linux Foundation"
        c.category = "Seguridad & Front-End"
        c.description = "Prácticas esenciales de seguridad para aplicaciones JavaScript/Node.js, prevención de vulnerabilidades OWASP Top 10, XSS, SSRF y mitigación de riesgos en la cadena de suministro de software."
        c.skills = "Seguridad en JavaScript, Seguridad en Node.js, Seguridad de Aplicaciones Web, OWASP Top 10, XSS, SSRF"
      end
    when 2
      Mobility.with_locale(:"pt-PT") do
        c.title = "Programação: da abstração à implementação em Python"
        c.issuer = "Instituto Superior Técnico (MOOC Técnico)"
        c.category = "Engenharia de Software"
        c.description = "Estruturas de dados avançadas, pensamento algorítmico, abstração e implementação de soluções eficientes em Python."
        c.skills = "Python, Lógica de Programação, Estruturas de Dados, Algoritmos"
      end
      Mobility.with_locale(:en) do
        c.title = "Programming: from abstraction to implementation in Python"
        c.issuer = "Instituto Superior Técnico (MOOC Técnico)"
        c.category = "Software Engineering"
        c.description = "Advanced data structures, algorithmic thinking, abstraction, and implementation of efficient solutions in Python."
        c.skills = "Python, Logic Programming, Data Structures, Algorithms"
      end
      Mobility.with_locale(:es) do
        c.title = "Programación: de la abstracción a la implementación en Python"
        c.issuer = "Instituto Superior Técnico (MOOC Técnico)"
        c.category = "Ingeniería de Software"
        c.description = "Estructuras de datos avanzadas, pensamiento algorítmico, abstracción e implementación de soluciones eficientes en Python."
        c.skills = "Python, Lógica de Programación, Estructuras de Datos, Algoritmos"
      end
    when 3
      Mobility.with_locale(:"pt-PT") do
        c.title = "Proposta de Valor Única"
        c.issuer = "HP LIFE"
        c.category = "Estratégia & Negócios"
        c.description = "Metodologias para definição e validação de propostas de valor diferenciadas e posicionamento estratégico no mercado."
        c.skills = "Proposta de Valor, Estratégia de Negócios, Posicionamento de Mercado, Análise Competitiva"
      end
      Mobility.with_locale(:en) do
        c.title = "Unique Value Proposition"
        c.issuer = "HP LIFE"
        c.category = "Strategy & Business"
        c.description = "Methodologies for defining and validating distinctive value propositions and strategic market positioning."
        c.skills = "Value Proposition, Business Strategy, Market Positioning, Competitive Analysis"
      end
      Mobility.with_locale(:es) do
        c.title = "Propuesta de Valor Exclusiva"
        c.issuer = "HP LIFE"
        c.category = "Estrategia y Negocios"
        c.description = "Metodologías para definir y validar propuestas de valor diferenciales y posicionamiento estratégico en el mercado."
        c.skills = "Propuesta de Valor, Estrategia de Negocios, Posicionamiento de Mercado, Análisis Competitivo"
      end
    when 4
      Mobility.with_locale(:"pt-PT") do
        c.title = "Análise de Resultados em Marketing Digital"
        c.issuer = "Sebrae Amazonas"
        c.category = "E-commerce & Estratégia Digital"
        c.description = "Métricas de aquisição, conversão e retenção para otimização contínua de performance e ROI em plataformas digitais."
        c.skills = "Marketing Digital, Métricas de Desempenho, Análise de Dados, Otimização de Conversão"
      end
      Mobility.with_locale(:en) do
        c.title = "Digital Marketing Results Analysis"
        c.issuer = "Sebrae Amazonas"
        c.category = "E-commerce & Digital Strategy"
        c.description = "Acquisition, conversion, and retention metrics for continuous performance optimization and digital ROI."
        c.skills = "Digital Marketing, Performance Metrics, Data Analysis, Conversion Optimization"
      end
      Mobility.with_locale(:es) do
        c.title = "Análisis de Resultados en Marketing Digital"
        c.issuer = "Sebrae Amazonas"
        c.category = "E-commerce y Estrategia Digital"
        c.description = "Métricas de adquisición, conversión y retención para optimización continua del rendimiento y ROI digital."
        c.skills = "Marketing Digital, Métricas de Rendimiento, Análisis de Datos, Optimización de Conversión"
      end
    when 5
      Mobility.with_locale(:"pt-PT") do
        c.title = "Marketing em Redes Sociais"
        c.issuer = "HP LIFE"
        c.category = "E-commerce & Estratégia Digital"
        c.description = "Criação de estratégias orientadas por dados para engajamento e conversão de audiências em múltiplos canais digitais."
        c.skills = "Estratégia de Redes Sociais, Campanhas de Marketing, Engajamento, Branding Digital"
      end
      Mobility.with_locale(:en) do
        c.title = "Social Media Marketing"
        c.issuer = "HP LIFE"
        c.category = "E-commerce & Digital Strategy"
        c.description = "Data-driven strategy creation for audience engagement and conversion across multiple digital channels."
        c.skills = "Social Media Strategy, Marketing Campaigns, Engagement, Digital Branding"
      end
      Mobility.with_locale(:es) do
        c.title = "Marketing en Redes Sociales"
        c.issuer = "HP LIFE"
        c.category = "E-commerce y Estrategia Digital"
        c.description = "Creación de estrategias basadas en datos para el engagement y la conversión de audiencias en múltiples canales digitales."
        c.skills = "Estrategia de Redes Sociales, Campañas de Marketing, Engagement, Branding Digital"
      end
    when 6
      Mobility.with_locale(:"pt-PT") do
        c.title = "Copilot: Domine a IA no Microsoft 365"
        c.issuer = "Open Academy"
        c.category = "Inovação & IA"
        c.description = "Aceleração de fluxos de trabalho e produtividade com modelos de IA generativa aplicados ao ambiente corporativo."
        c.skills = "Microsoft 365 Copilot, Inteligência Artificial Generativa, Produtividade, Engenharia de Prompt"
      end
      Mobility.with_locale(:en) do
        c.title = "Copilot: Master AI in Microsoft 365"
        c.issuer = "Open Academy"
        c.category = "Innovation & AI"
        c.description = "Workflow acceleration and productivity enhancement using generative AI models in corporate environments."
        c.skills = "Microsoft 365 Copilot, Generative AI at Work, Productivity, Prompt Engineering"
      end
      Mobility.with_locale(:es) do
        c.title = "Copilot: Domina la IA en Microsoft 365"
        c.issuer = "Open Academy"
        c.category = "Innovación e IA"
        c.description = "Aceleración de flujos de trabajo y productividad mediante modelos de IA generativa en entornos corporativos."
        c.skills = "Microsoft 365 Copilot, Inteligencia Artificial Generativa, Productividad, Ingeniería de Prompts"
      end
    when 7
      Mobility.with_locale(:"pt-PT") do
        c.title = "Masterclass: Inteligência Artificial na Rotina dos Designers"
        c.issuer = "EBAC - Escola Britânica de Artes Criativas e Tecnologia"
        c.category = "Inovação & IA"
        c.description = "Integração de ferramentas de IA generativa em processos de pesquisa, prototipagem e design de interface."
        c.skills = "Inteligência Artificial, Ferramentas de IA Generativa, Design de Interface, Fluxo Criativo com IA"
      end
      Mobility.with_locale(:en) do
        c.title = "Masterclass: Artificial Intelligence in Designers' Routine"
        c.issuer = "EBAC - British School of Creative Arts and Technology"
        c.category = "Innovation & AI"
        c.description = "Integrating generative AI tools into user research, prototyping, and UI design workflows."
        c.skills = "Artificial Intelligence, Generative AI Tools, Interface Design, Creative Workflow with AI"
      end
      Mobility.with_locale(:es) do
        c.title = "Masterclass: La Inteligencia Artificial en la rutina de los diseñadores"
        c.issuer = "EBAC - Escola Britânica de Artes Criativas e Tecnologia"
        c.category = "Innovación e IA"
        c.description = "Integración de herramientas de IA generativa en procesos de investigación, prototipado y diseño de interfaz."
        c.skills = "Inteligencia Artificial, Herramientas de IA Generativa, Diseño de Interfaz, Flujo Creativo con IA"
      end
    when 9
      Mobility.with_locale(:"pt-PT") do
        c.title = "Design Sprint em Projetos de Transformação Digital"
        c.issuer = "Enap - Escola Nacional de Administração Pública"
        c.category = "Design UX/UI & Produto"
        c.description = "Aplicação prática da metodologia Design Sprint para validação rápida de hipóteses e prototipagem em serviços digitais complexos."
        c.skills = "Design Sprint, Metodologias Ágeis, Prototipagem Rápida, Transformação Digital, Resolução de Problemas"
      end
      Mobility.with_locale(:en) do
        c.title = "Design Sprint in Digital Transformation Projects"
        c.issuer = "Enap - National School of Public Administration"
        c.category = "UX/UI & Product Design"
        c.description = "Practical application of Design Sprint methodology for rapid hypothesis validation and prototyping in complex digital services."
        c.skills = "Design Sprint, Agile Methodologies, Rapid Prototyping, Digital Transformation, Problem Solving"
      end
      Mobility.with_locale(:es) do
        c.title = "Design Sprint en Proyectos de Transformación Digital"
        c.issuer = "Enap - Escuela Nacional de Administración Pública"
        c.category = "Diseño UX/UI y Producto"
        c.description = "Aplicación práctica de la metodología Design Sprint para validación rápida de hipótesis y prototipado en servicios digitales complejos."
        c.skills = "Design Sprint, Metodologías Ágiles, Prototipado Rápido, Transformación Digital, Resolución de Problemas"
      end
    when 10
      Mobility.with_locale(:"pt-PT") do
        c.title = "Bootcamp de UX Design para Todos"
        c.issuer = "How Bootcamps"
        c.category = "Design UX/UI & Produto"
        c.description = "Processos completos de design centrado no utilizador: pesquisa, arquitetura de informação, wireframing e testes de usabilidade."
        c.skills = "UX Design, Pesquisa com Utilizadores, Arquitetura de Informação, Wireframing, Prototipagem"
      end
      Mobility.with_locale(:en) do
        c.title = "UX Design Bootcamp for all"
        c.issuer = "How Bootcamps"
        c.category = "UX/UI & Product Design"
        c.description = "Complete user-centered design lifecycle: research, information architecture, wireframing, and usability testing."
        c.skills = "UX Design, User Research, Information Architecture, Wireframing, Prototyping"
      end
      Mobility.with_locale(:es) do
        c.title = "Bootcamp UX Design para todos"
        c.issuer = "How Bootcamps"
        c.category = "Diseño UX/UI y Producto"
        c.description = "Procesos completos de diseño centrado en el usuario: investigación, arquitectura de información, wireframing y pruebas de usabilidad."
        c.skills = "UX Design, Investigación con Usuarios, Arquitectura de Información, Wireframing, Prototipado"
      end
    when 11
      Mobility.with_locale(:"pt-PT") do
        c.title = "Psicologia Organizacional"
        c.issuer = "Universidade Estadual do Maranhão (UEMA)"
        c.category = "Gestão & Comportamento"
        c.description = "Dinâmicas de grupo, comportamento humano no ambiente corporativo, saúde mental e gestão de clima organizacional."
        c.skills = "Psicologia Organizacional, Saúde Mental no Trabalho, Comportamento Humano, Gestão de Clima, Liderança"
      end
      Mobility.with_locale(:en) do
        c.title = "Organizational Psychology"
        c.issuer = "Universidade Estadual do Maranhão (UEMA)"
        c.category = "Management & Behavior"
        c.description = "Group dynamics, human behavior in corporate environments, workplace mental health, and organizational climate management."
        c.skills = "Organizational Psychology, Workplace Mental Health, Human Behavior, Climate Management, Leadership"
      end
      Mobility.with_locale(:es) do
        c.title = "Psicología Organizacional"
        c.issuer = "Universidade Estadual do Maranhão (UEMA)"
        c.category = "Gestión y Comportamiento"
        c.description = "Dinámicas de grupo, comportamiento humano en el entorno corporativo, salud mental y gestión de clima organizacional."
        c.skills = "Psicología Organizacional, Salud Mental en el Trabajo, Comportamiento Humano, Gestión de Clima, Liderazgo"
      end
    when 12
      Mobility.with_locale(:"pt-PT") do
        c.title = "Plano de Carreira"
        c.issuer = "EBAC - Escola Britânica de Artes Criativas e Tecnologia"
        c.category = "Gestão & Desenvolvimento"
        c.description = "Estratégia de desenvolvimento profissional, liderança, autogestão e planeamento de carreira de longo prazo."
        c.skills = "Gestão de Carreira, Autogestão, Planeamento Estratégico Pessoal, Liderança"
      end
      Mobility.with_locale(:en) do
        c.title = "Career Plan"
        c.issuer = "EBAC - Escola Britânica de Artes Criativas e Tecnologia"
        c.category = "Management & Development"
        c.description = "Professional development strategy, leadership, self-management, and long-term career planning."
        c.skills = "Career Management, Self Management, Personal Strategic Planning, Leadership"
      end
      Mobility.with_locale(:es) do
        c.title = "Plan de Carrera"
        c.issuer = "EBAC - Escola Britânica de Artes Criativas e Tecnologia"
        c.category = "Gestión y Desarrollo"
        c.description = "Estrategia de desarrollo profesional, liderazgo, autogestión y planificación de carrera a largo plazo."
        c.skills = "Gestión de Carrera, Autogestión, Planificación Estratégica Personal, Liderazgo"
      end
    when 14
      Mobility.with_locale(:"pt-PT") do
        c.title = "Avaliação Psicológica em Manaus"
        c.issuer = "Faculdade Santa Teresa"
        c.category = "Ciências Humanas"
        c.description = "Técnicas e instrumentos de avaliação comportamental, psicodiagnóstico e análise psicossocial aplicada."
        c.skills = "Avaliação Psicológica, Análise Comportamental, Diagnóstico, Psicologia Aplicada"
      end
      Mobility.with_locale(:en) do
        c.title = "Psychological Assessment in Manaus"
        c.issuer = "Faculdade Santa Teresa"
        c.category = "Human Sciences"
        c.description = "Behavioral assessment techniques and instruments, psychodiagnostics, and applied psychosocial analysis."
        c.skills = "Psychological Assessment, Behavioral Analysis, Diagnosis, Applied Psychology"
      end
      Mobility.with_locale(:es) do
        c.title = "Evaluación Psicológica en Manaus"
        c.issuer = "Faculdade Santa Teresa"
        c.category = "Ciencias Humanas"
        c.description = "Técnicas e instrumentos de evaluación conductual, psicodiagnóstico y análisis psicosocial aplicado."
        c.skills = "Evaluación Psicológica, Análisis Conductual, Diagnóstico, Psicología Aplicada"
      end
    end
    c.save!
  end
  puts "✓ Todas as certificações foram sincronizadas nos 3 idiomas."
end

run_full_sync!
