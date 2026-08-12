I18n.locale = :'pt-BR'

experiences = ExperienceItem.all
en_translations = [
  { role: "Senior Product Designer", company: "Matterna", type_name: "Full-time", summary: "Conception, product design, and visual strategy for a maternity-focused platform. Role: Complete leadership of the design cycle (Discovery, Design System, UX/UI, information architecture, and brand strategy).\n\nDelivery: Construction of visual identity, high-fidelity prototyping, and structuring of an e-commerce and digital ecosystem focused on high conversion and user experience.", highlights: "Authorial project focused on product innovation and validation of end-to-end design processes.", skills: "UX/UI Design, Branding, Product Strategy, E-commerce, Design Systems" },
  { role: "Art Director", company: "Agência Taió", type_name: "Full-time", summary: "Development of visual communication projects, graphic design, and branding for nationally renowned clients.\nCreation of pieces focused on increasing conversion rates and strengthening brand recognition.", highlights: "Brand repositioning campaigns.", skills: "Art Direction, Graphic Design, Branding" },
  { role: "Art Director", company: "BZ Propaganda & Marketing", type_name: "Full-time", summary: "Creation and execution of online and offline advertising campaigns for large clients, such as Grupo Saboroso.\nArt direction and design strategies focused on market positioning.", highlights: "High-impact advertising campaigns.", skills: "Advertising, Art Direction, Online/Offline Marketing" },
  { role: "Academic Researcher", company: "ULBRA - Universidade Luterana do Brasil", type_name: "Contract", summary: "Scientific research and writing of Chapter V (pp. 53-66) of the book 'Educação em Saúde: gravidez na adolescência, bullying, prevenção de acidentes, envelhecimento e bem-estar na Amazônia'.\nPsychosocial analysis and preparation of diagnoses on the impacts of early pregnancy.", highlights: "Published book chapter.", skills: "Academic Research, Psychosocial Analysis, Writing" },
  { role: "Intern University Assistant", company: "ULBRA - Universidade Luterana do Brasil", type_name: "Internship", summary: "Observational practice and preparation of diagnoses in psychopathology and community psychology (Workload: 76h).", highlights: "Community psychology practice.", skills: "Psychopathology, Community Psychology, Clinical Observation" },
  { role: "Art Director", company: "All Night Pub", type_name: "Full-time", summary: "Management of the brand's visual identity, creation of institutional materials, menus, and promotional pieces.\nSocial media management and visual planning of campaigns.", highlights: "Event branding and social media management.", skills: "Brand Identity, Social Media Design, Promotional Materials" },
  { role: "Art Director", company: "Magic Publicidade", type_name: "Full-time", summary: "Production of materials for on/offline campaigns, management of deadlines and creative team workflow.", highlights: "Creative team coordination.", skills: "Campaign Production, Workflow Management, Art Direction" }
]

es_translations = [
  { role: "Diseñador de Producto Senior", company: "Matterna", type_name: "Tiempo Completo", summary: "Concepción, diseño de producto y estrategia visual para una plataforma centrada en la maternidad. Rol: Liderazgo completo del ciclo de diseño (Discovery, Design System, UX/UI, arquitectura de la información y estrategia de marca).\n\nEntrega: Construcción de identidad visual, prototipado de alta fidelidad y estructuración de comercio electrónico y ecosistema digital centrado en alta conversión y experiencia de usuario.", highlights: "Proyecto de autor centrado en innovación de producto y validación de procesos de diseño de extremo a extremo.", skills: "Diseño UX/UI, Branding, Estrategia de Producto, E-commerce, Design Systems" },
  { role: "Director de Arte", company: "Agência Taió", type_name: "Tiempo Completo", summary: "Desarrollo de proyectos de comunicación visual, diseño gráfico y branding para clientes de renombre nacional.\nCreación de piezas enfocadas en aumentar las tasas de conversión y fortalecer el reconocimiento de marca.", highlights: "Campañas de reposicionamiento de marca.", skills: "Dirección de Arte, Diseño Gráfico, Branding" },
  { role: "Director de Arte", company: "BZ Propaganda & Marketing", type_name: "Tiempo Completo", summary: "Creación y ejecución de campañas publicitarias en línea y fuera de línea para grandes clientes, como el Grupo Saboroso.\nDirección de arte y estrategias de diseño enfocadas en el posicionamiento de mercado.", highlights: "Campañas publicitarias de alto impacto.", skills: "Publicidad, Dirección de Arte, Marketing Online/Offline" },
  { role: "Investigador Académico", company: "ULBRA - Universidade Luterana do Brasil", type_name: "Contrato", summary: "Investigación científica y redacción del Capítulo V (pp. 53-66) del libro 'Educação em Saúde: gravidez na adolescência, bullying, prevención de accidentes, envejecimiento y bienestar en la Amazonia'.\nAnálisis psicosocial y preparación de diagnósticos sobre los impactos del embarazo precoz.", highlights: "Capítulo de libro publicado.", skills: "Investigación Académica, Análisis Psicosocial, Redacción" },
  { role: "Asistente Universitario en Prácticas", company: "ULBRA - Universidade Luterana do Brasil", type_name: "Prácticas", summary: "Práctica observacional y preparación de diagnósticos en psicopatología y psicología comunitaria (Carga horaria: 76h).", highlights: "Práctica en psicología comunitaria.", skills: "Psicopatología, Psicología Comunitaria, Observación Clínica" },
  { role: "Director de Arte", company: "All Night Pub", type_name: "Tiempo Completo", summary: "Gestión de la identidad visual de la marca, creación de materiales institucionales, menús y piezas promocionales.\nGestión de redes sociales y planificación visual de campañas.", highlights: "Branding de eventos y gestión de redes sociales.", skills: "Identidad de Marca, Diseño para Redes Sociales, Materiales Promocionales" },
  { role: "Director de Arte", company: "Magic Publicidade", type_name: "Tiempo Completo", summary: "Producción de materiales para campañas en línea y fuera de línea, gestión de plazos y flujo de trabajo del equipo creativo.", highlights: "Coordinación del equipo creativo.", skills: "Producción de Campañas, Gestión del Flujo de Trabajo, Dirección de Arte" }
]

experiences.order(created_at: :desc).each_with_index do |e, i|
  e.skip_auto_translate = true
  Mobility.with_locale(:en) do
    en_translations[i].each { |k, v| e.send("#{k}=", v) }
  end
  Mobility.with_locale(:es) do
    es_translations[i].each { |k, v| e.send("#{k}=", v) }
  end
  Mobility.with_locale(:'pt-PT') do
    Mobility.with_locale(:'pt-BR') do
      e.class.mobility_attributes.each { |a| e.send("#{a}=", e.public_send(a)) }
    end
  end
  e.save!
end
puts "Experiências traduzidas com sucesso!"

academic_bgs = AcademicBackground.order(created_at: :desc)
en_academic = [
  { degree: "Bachelor in Psychology", institution: "Faculdade Santa Teresa", field_of_study: "Psychology", research_focus: "Comprehensive training in Humanities and Psychology, focusing on Organizational Psychology, Community Psychology, Public Health, and Psychopathology.\n\nKey Activities:\n• Scientific Research: Co-author of Chapter V ('Unraveling the harms of early pregnancy in pre-adolescents and adolescents') in the book Health Education: teenage pregnancy, bullying, accident prevention, aging, and well-being in the Amazon (ULBRA, 2021).\n• Internship in Psychopathology: Observational practice and preparation of diagnoses focused on group processes, community psychology, and public health (Workload: 76h).", thesis: "Unraveling the harms of early pregnancy for pre-adolescents and adolescents (Published as a book chapter - ULBRA)." },
  { degree: "High School Education", institution: "Colégio Estadual Professor José Carlos de Almeida", field_of_study: "General and Scientific Education", research_focus: "General and scientific high school education, with a total workload of 3,200 hours.\n\nMain curricular components: Portuguese Language, Mathematics, Physics, Chemistry, Biology, History, Geography, Philosophy, Art, and Foreign Languages (English and Spanish).", thesis: "" }
]

es_academic = [
  { degree: "Licenciatura en Psicología", institution: "Faculdade Santa Teresa", field_of_study: "Psicología", research_focus: "Formación integral en Humanidades y Psicología, con enfoque en Psicología Organizacional, Psicología Comunitaria, Salud Pública y Psicopatología.\n\nActividades Clave:\n• Investigación Científica: Coautor del Capítulo V ('Desentrañando los daños del embarazo precoz en preadolescentes y adolescentes') en el libro Educación en Salud: embarazo en la adolescencia, bullying, prevención de accidentes, envejecimiento y bienestar en la Amazonía (ULBRA, 2021).\n• Pasantía en Psicopatología: Práctica observacional y preparación de diagnósticos enfocados en procesos grupales, psicología comunitaria y salud pública (Carga horaria: 76h).", thesis: "Desentrañando los daños del embarazo precoz para preadolescentes y adolescentes (Publicado como capítulo de libro - ULBRA)." },
  { degree: "Educación Secundaria", institution: "Colégio Estadual Professor José Carlos de Almeida", field_of_study: "Educación General y Científica", research_focus: "Educación secundaria general y científica, con una carga horaria total de 3.200 horas.\n\nPrincipales componentes curriculares: Lengua Portuguesa, Matemáticas, Física, Química, Biología, Historia, Geografía, Filosofía, Arte e Idiomas Extranjeros (Inglés y Español).", thesis: "" }
]

academic_bgs.each_with_index do |a, i|
  a.skip_auto_translate = true
  Mobility.with_locale(:en) do
    en_academic[i].each { |k, v| a.send("#{k}=", v) }
  end
  Mobility.with_locale(:es) do
    es_academic[i].each { |k, v| a.send("#{k}=", v) }
  end
  Mobility.with_locale(:'pt-PT') do
    Mobility.with_locale(:'pt-BR') do
      a.class.mobility_attributes.each { |attr| a.send("#{attr}=", a.public_send(attr)) }
    end
  end
  a.save!
end
puts "Backgrounds acadêmicos traduzidos com sucesso!"
