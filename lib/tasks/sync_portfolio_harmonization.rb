# frozen_string_literal: true

require "rails"

puts "=== SINCRONIZANDO E HARMONIZANDO TODOS OS ESTUDOS DE CASO (PT-PT, EN, ES) ==="

case_studies_data = {
  1 => {
    "pt-PT" => {
      title: "Cubos Academy",
      client: "Cubos Academy",
      role: "UI/UX Design",
      period: "Set 2023",
      tagline: "Plataforma Educacional de Tecnologia & Design",
      summary: "Desenho da experiência do usuário e interface da plataforma de ensino da Cubos Academy, focada em retenção e clareza no processo de aprendizagem.",
      full_description: "Projeto completo de UX/UI para a plataforma digital de cursos de tecnologia e design da Cubos Academy. Estruturação da jornada do aluno, catálogo interativo, dashboards de progresso e sistema de aulas com alta usabilidade e consistência visual.",
      challenge: "A plataforma anterior apresentava fricção na navegação entre módulos, perda de engajamento dos alunos e inconsistência visual nos componentes interativos.",
      solution: "Construção de um ecossistema visual baseado em Design Tokens, redesenho integral da esteira de aprendizagem e simplificação das métricas de progresso com foco na experiência do estudante.",
      behavioral_insight: "Aplicação da Lei de Hick e microfeedbacks imediatos para reduzir a sobrecarga de decisão durante a escolha de módulos e atividades práticas.",
      tags: "UI/UX Design, Design de Interações, Direção de Arte, Figma, EdTech"
    },
    "en" => {
      title: "Cubos Academy",
      client: "Cubos Academy",
      role: "UI/UX Design",
      period: "Sep 2023",
      tagline: "EdTech Learning & Design Platform",
      summary: "End-to-end user experience and UI design for Cubos Academy's educational platform, focusing on student retention and learning flow clarity.",
      full_description: "Comprehensive UX/UI project for Cubos Academy's tech and design learning platform. Structuring the student journey, course catalog, progress dashboards, and interactive learning player with extreme visual consistency.",
      challenge: "The legacy platform suffered from navigation friction between modules, low completion rates, and visual inconsistency across interactive components.",
      solution: "Engineered a scalable token-based Design System, overhauled the student journey, and streamlined learning metrics to maximize focus and engagement.",
      behavioral_insight: "Applied Hick's Law and immediate micro-feedbacks to minimize cognitive load when navigating course curriculums and exercises.",
      tags: "UI/UX Design, Interaction Design, Art Direction, Figma, EdTech"
    },
    "es" => {
      title: "Cubos Academy",
      client: "Cubos Academy",
      role: "Diseño UI/UX",
      period: "Sep 2023",
      tagline: "Plataforma Educativa de Tecnología y Diseño",
      summary: "Diseño de experiencia de usuario e interfaz de la plataforma educativa de Cubos Academy, centrada en retención y claridad en el aprendizaje.",
      full_description: "Proyecto integral de UX/UI para la plataforma de cursos de tecnología y diseño de Cubos Academy. Estructuración del recorrido del estudiante, catálogo, paneles de progreso y reproductor educativo interactivo.",
      challenge: "La plataforma anterior presentaba fricción de navegación, pérdida de retención y falta de consistencia visual en los componentes.",
      solution: "Construcción de un sistema visual basado en Design Tokens, rediseño del flujo educativo y simplificación de las métricas de progreso.",
      behavioral_insight: "Aplicación de la Ley de Hick y micro-retroalimentaciones inmediatas para reducir la sobrecarga cognitiva durante el estudio.",
      tags: "Diseño UI/UX, Diseño de Interacción, Dirección de Arte, Figma, EdTech"
    }
  },
  2 => {
    "pt-PT" => {
      title: "Kayo Paladino",
      client: "Kayo Paladino",
      role: "Product Design",
      period: "Jul 2024",
      tagline: "Mobile App & Identidade de Marca Pessoal",
      summary: "Concepção do produto digital mobile e estratégia de posicionamento de marca, integrando ergonomia visual e arquitetura de fluxos.",
      full_description: "Desenvolvimento de aplicativo móvel para mentoria e consultoria fitness/lifestyle, conectando treinos personalizados, acompanhamento nutricional e métricas de desempenho.",
      challenge: "Criar uma experiência mobile intuitiva e motivadora para usuários com rotinas agitadas, unificando identidade visual forte e velocidade de uso.",
      solution: "Interface focada em ergonomia com botões acessíveis ao polegar, modo escuro de alto contraste e onboarding interativo em 3 etapas.",
      behavioral_insight: "Uso do Efeito de Progresso Dotado e metas visuais incrementais para aumentar a consistência e adesão aos treinos diários.",
      tags: "Product Design, Mobile App, UI/UX Design, Figma, Branding"
    },
    "en" => {
      title: "Kayo Paladino",
      client: "Kayo Paladino",
      role: "Product Design",
      period: "Jul 2024",
      tagline: "Mobile App & Personal Brand Identity",
      summary: "Digital mobile product conception and brand positioning strategy, integrating visual ergonomics and intuitive UX flows.",
      full_description: "End-to-end mobile application development for fitness/lifestyle coaching, combining customized training regimes, nutrition logging, and performance analytics.",
      challenge: "Design an intuitive, engaging mobile experience for fast-paced routines while establishing a distinct personal brand identity.",
      solution: "Ergonomic mobile UI optimized for one-thumb reach, high-contrast dark mode, and a frictionless 3-step interactive onboarding flow.",
      behavioral_insight: "Leveraged the Endowed Progress Effect and visual milestones to reinforce habit formation and daily workout adherence.",
      tags: "Product Design, Mobile App, UI/UX Design, Figma, Branding"
    },
    "es" => {
      title: "Kayo Paladino",
      client: "Kayo Paladino",
      role: "Diseño de Producto",
      period: "Jul 2024",
      tagline: "App Móvil e Identidad de Marca Personal",
      summary: "Concepción de producto digital móvil y estrategia de posicionamiento de marca, combinando ergonomía visual y flujos intuitivos.",
      full_description: "Desarrollo de aplicación móvil para asesoría fitness y estilo de vida, integrando planes personalizados, nutrición y métricas de desempeño.",
      challenge: "Crear una experiencia móvil fluida y motivadora para usuarios ocupados, unificando una identidad de marca prémium y alta velocidad.",
      solution: "Interfaz ergonómica optimizada para uso con una sola mano, modo oscuro de alto contraste y onboarding interactivo de 3 pasos.",
      behavioral_insight: "Uso del Efecto de Progreso Otorgado y recompensas visuales para aumentar la adherencia y el hábito de entrenamiento diario.",
      tags: "Diseño de Producto, App Móvil, Diseño UI/UX, Figma, Branding"
    }
  },
  3 => {
    "pt-PT" => {
      title: "Tecnorádio",
      client: "Tecnorádio",
      role: "Design Gráfico",
      period: "Jul 2024",
      tagline: "Comunicação Visual & Estratégia de Conteúdo",
      summary: "Desenvolvimento de identidade de comunicação e estratégia gráfica para múltiplos canais digitais e impressos.",
      full_description: "Campanhas publicitárias, peças de divulgação institucional, identidade gráfica para eventos e padronização visual para redes sociais e canais de streaming.",
      challenge: "Modernizar a comunicação de uma emissora de rádio tradicional sem perder a conexão afetiva com sua audiência consolidada.",
      solution: "Identidade visual dinâmica com tipografia geométrica marcante, paleta de cores vibrante e templates modulares para a equipe de conteúdo.",
      behavioral_insight: "Hierarquia visual baseada no padrão Z-reading para aumentar o tempo de retenção em posts e cartazes informativos.",
      tags: "Design Gráfico, Estratégia Digital, Social Media, Publicidade"
    },
    "en" => {
      title: "Tecnorádio",
      client: "Tecnorádio",
      role: "Graphic Design",
      period: "Jul 2024",
      tagline: "Visual Communication & Content Strategy",
      summary: "Development of comprehensive visual communication and design strategy across digital and offline media channels.",
      full_description: "Advertising campaigns, institutional branding, event visual systems, and modular social media templates for broadcast and streaming media.",
      challenge: "Modernize the visual identity of a traditional radio broadcaster while preserving brand recognition and community connection.",
      solution: "Dynamic visual identity featuring bold geometric typography, vibrant color palettes, and flexible production templates for content teams.",
      behavioral_insight: "Structured visual hierarchy using the Z-reading pattern to maximize retention on informational posts and outdoor promotional posters.",
      tags: "Graphic Design, Digital Strategy, Social Media, Advertising"
    },
    "es" => {
      title: "Tecnorádio",
      client: "Tecnorádio",
      role: "Diseño Gráfico",
      period: "Jul 2024",
      tagline: "Comunicación Visual y Estrategia de Contenido",
      summary: "Desarrollo de comunicación visual integral y estrategia de diseño para canales digitales y tradicionales.",
      full_description: "Campañas publicitarias, identidad gráfica para eventos y plantillas modulares para redes sociales y transmisión en vivo.",
      challenge: "Modernizar la comunicación de una emisora de radio consolidada preservando su conexión histórica con la audiencia.",
      solution: "Identidad dinámica con tipografía geométrica potente, colores vibrantes y plantillas ágiles para producción de contenido.",
      behavioral_insight: "Jerarquía visual en patrón Z para aumentar la retención y comprensión inmediata en piezas informativas.",
      tags: "Diseño Gráfico, Estrategia Digital, Redes Sociales, Publicidad"
    }
  },
  4 => {
    "pt-PT" => {
      title: "Gráfica Vitória",
      client: "Gráfica Vitória",
      role: "Design Gráfico",
      period: "Jul 2024",
      tagline: "Design Gráfico Editorial & Campanhas Institucionais",
      summary: "Direção de arte e projetos gráficos de grande formato e editoriais para campanhas de alto alcance e impacto institucional.",
      full_description: "Elaboração de catálogos de produtos, materiais editoriais com acabamentos especiais, campanhas institucionais e sinalização ambiental corporativa.",
      challenge: "Evidenciar a precisão técnica e as possibilidades de impressão sofisticadas da gráfica através de seus próprios materiais institucionais.",
      solution: "Sistemas de grid compositivos rigorosos, tipografia suíça refinada e seleção precisa de papéis e acabamentos especiais.",
      behavioral_insight: "Uso do princípio da Continuidade de Gestalt para orientar o olhar do leitor através de catálogos técnicos densos.",
      tags: "Design Gráfico, Impressos, Branding, Editorial"
    },
    "en" => {
      title: "Gráfica Vitória",
      client: "Gráfica Vitória",
      role: "Graphic Design",
      period: "Jul 2024",
      tagline: "Editorial Graphic Design & Institutional Campaigns",
      summary: "Art direction and large-format editorial graphic projects for high-reach institutional campaigns and specialty print.",
      full_description: "Product catalogs, high-end editorial books with specialty finishes, corporate campaigns, and environmental signage systems.",
      challenge: "Showcase the print house's technical precision and luxury finishing capabilities through its own brand collateral.",
      solution: "Rigorous Swiss grid systems, refined typography, and purposeful selection of premium paper stocks and print treatments.",
      behavioral_insight: "Applied Gestalt's Continuity principle to guide reader attention effortlessly through information-dense product catalogs.",
      tags: "Graphic Design, Print Design, Branding, Editorial"
    },
    "es" => {
      title: "Gráfica Vitória",
      client: "Gráfica Vitória",
      role: "Diseño Gráfico",
      period: "Jul 2024",
      tagline: "Diseño Gráfico Editorial y Campañas Institucionales",
      summary: "Dirección de arte y proyectos editoriales de gran formato para campañas institucionales y acabados gráficos especiales.",
      full_description: "Elaboración de catálogos de productos, piezas editoriales prémium, campañas corporativas y señalización ambiental.",
      challenge: "Demostrar la precisión técnica y las posibilidades de impresión de alta gama a través del propio material corporativo.",
      solution: "Sistemas de retícula suiza precisos, tipografía editorial refinada y selección cuidada de papeles y acabados.",
      behavioral_insight: "Uso del principio de Continuidad de Gestalt para guiar la lectura fluida en catálogos técnicos densos.",
      tags: "Diseño Gráfico, Impresos, Branding, Editorial"
    }
  },
  5 => {
    "pt-PT" => {
      title: "Adriana Nunes",
      client: "Adriana Nunes",
      role: "Estratégia de Marca",
      period: "Jul 2024",
      tagline: "Branding & Identidade Visual de Alto Padrão",
      summary: "Criação de identidade visual e estratégia de marca para posicionamento premium no mercado corporativo e de consultoria executiva.",
      full_description: "Redesenho de marca pessoal, paleta cromática sofisticada, papelaria de alto padrão, diretrizes de presença digital e material de apresentação para clientes C-Level.",
      challenge: "Traduzir a autoridade e a exclusividade do atendimento executivo em uma marca minimalista, elegante e memorável.",
      solution: "Monograma autoral refinado, contraste equilibrado de tipografia com e sem serifa e guia de aplicação para mídias físicas e digitais.",
      behavioral_insight: "Efeito Halo visual através de elementos monocromáticos dourados e espaço negativo generoso para reforçar valor percebido.",
      tags: "Branding, Identidade Visual, Estratégia de Marca, Design de Luxo"
    },
    "en" => {
      title: "Adriana Nunes",
      client: "Adriana Nunes",
      role: "Brand Strategy",
      period: "Jul 2024",
      tagline: "High-End Branding & Visual Identity",
      summary: "Brand identity creation and positioning strategy for executive consulting and premium professional services.",
      full_description: "Personal brand overhaul, refined color palette, bespoke corporate stationery, executive pitch decks, and digital presence guidelines for C-Level audiences.",
      challenge: "Translate executive authority and high-touch advisory into a minimalist, sophisticated, and memorable brand universe.",
      solution: "Custom monogram emblem, elegant serif/sans-serif typographic pairing, and comprehensive digital/print design standards.",
      behavioral_insight: "Utilized visual Halo Effect via restrained gold/monochrome palettes and generous whitespace to elevate perceived brand value.",
      tags: "Branding, Visual Identity, Brand Strategy, Luxury Design"
    },
    "es" => {
      title: "Adriana Nunes",
      client: "Adriana Nunes",
      role: "Estrategia de Marca",
      period: "Jul 2024",
      tagline: "Branding e Identidad Visual de Alto Nivel",
      summary: "Creación de identidad visual y estrategia de marca para posicionamiento prémium en consultoría ejecutiva y servicios corporativos.",
      full_description: "Rediseño de marca personal, paleta sofisticada, papelería ejecutiva, presentaciones C-Level y manual de marca para entornos digitales y físicos.",
      challenge: "Transmitir autoridad y exclusividad en una identidad minimalista, elegante y perdurable.",
      solution: "Monograma autoral, contraste tipográfico refinado y directrices claras de aplicación visual.",
      behavioral_insight: "Efecto Halo mediante paleta monocromática y amplio espacio en blanco para elevar el valor percibido del servicio.",
      tags: "Branding, Identidad Visual, Estrategia de Marca, Diseño de Lujo"
    }
  },
  6 => {
    "pt-PT" => {
      title: "LadyBee",
      client: "LadyBee",
      role: "E-Commerce",
      period: "Jul 2024",
      tagline: "Identidade de Marca & Experiência Digital Gastronômica",
      summary: "Identidade visual para confeitaria artesanal de alto padrão e estruturação do catálogo digital para encomendas e e-commerce.",
      full_description: "Projeto de marca completo, embalagens premium, fotografia de produtos com direção de arte e plataforma web para pedidos rápidos e personalizados.",
      challenge: "Transformar a experiência física e artesanal dos produtos em uma jornada digital que transmitisse sabor, elegância e confiabilidade.",
      solution: "Identidade visual acolhedora com tons pastéis elegantes, iconografia delicada e fluxo de pedidos mobile-first sem atrito.",
      behavioral_insight: "Fotografia sensorial com close-ups em alta definição para ativar o desejo de consumo e reduzir a hesitação no checkout.",
      tags: "Branding, E-Commerce, Social Media, Packaging"
    },
    "en" => {
      title: "LadyBee",
      client: "LadyBee",
      role: "E-Commerce",
      period: "Jul 2024",
      tagline: "Brand Identity & Culinary Digital Experience",
      summary: "Brand identity for an artisanal bakery and creation of an intuitive digital storefront for custom orders and online delivery.",
      full_description: "Complete visual identity, packaging system, art-directed food photography, and a mobile-first online ordering experience for artisanal confections.",
      challenge: "Translate the warmth and artisanal quality of the physical bakery into a seamless digital journey that builds instant trust and appetite.",
      solution: "Warm color scheme with elegant pastel hues, delicate iconography, and a frictionless mobile-first checkout flow.",
      behavioral_insight: "High-definition sensory food photography in key focal areas to trigger appetite appeal and minimize checkout hesitation.",
      tags: "Branding, E-Commerce, Social Media, Packaging"
    },
    "es" => {
      title: "LadyBee",
      client: "LadyBee",
      role: "E-Commerce",
      period: "Jul 2024",
      tagline: "Identidad de Marca y Experiencia Digital Gastronómica",
      summary: "Identidad de marca para pastelería artesanal prémium y estructuración del catálogo digital para pedidos y comercio electrónico.",
      full_description: "Diseño de marca, empaques, dirección de arte fotográfica y plataforma web optimizada para pedidos móviles ágiles.",
      challenge: "Trasladar la calidez y el acabado artesanal a una experiencia digital que inspire confianza y deseo de compra.",
      solution: "Paleta en tonos pastel elegantes, iconografía delicada y proceso de compra sin fricción.",
      behavioral_insight: "Fotografía sensorial en primeros planos para activar el apetito visual y reducir dudas en el pago.",
      tags: "Branding, E-Commerce, Redes Sociales, Packaging"
    }
  },
  7 => {
    "pt-PT" => {
      title: "Yorrany",
      client: "Yorrany Braga",
      role: "Estratégia de Marca",
      period: "Ago 2024",
      tagline: "Identidade Visual Autoral & Sistema Tipográfico",
      summary: "Sistema de identidade visual autoral e tipografia personalizada refletindo a interseção entre design de produto, psicologia e engenharia.",
      full_description: "Construção da marca autoral Yorrany, diretrizes de Design System (Dark/Light), design tokens e manual de aplicação para portfólio digital e comunicação executiva internacional.",
      challenge: "Sintetizar 20 anos de carreira multidisciplinar em uma identidade atemporal, técnica e profundamente humana.",
      solution: "Logotipo geométrico minimalista, paleta com o azul elétrico icônico (#003CA5) e tipografia suíça rigorosamente hierarquizada.",
      behavioral_insight: "Alto contraste cromático e proporções áureas para gerar fixação mnemônica instantânea e clareza na leitura.",
      tags: "Branding, Tipografia, Identidade Visual, Design System"
    },
    "en" => {
      title: "Yorrany",
      client: "Yorrany Braga",
      role: "Brand Strategy",
      period: "Aug 2024",
      tagline: "Authorial Visual Identity & Typographic System",
      summary: "Personal visual identity system and bespoke typography embodying the convergence of product design, cognitive psychology, and code.",
      full_description: "Creation of the Yorrany brand ecosystem, Dark/Light Design System tokens, and international visual standards for digital portfolio and executive consulting.",
      challenge: "Synthesize a 20-year multidisciplinary career into a timeless, technical, yet deeply human visual brand language.",
      solution: "Minimalist geometric monogram, signature electric blue (#003CA5) accent, and strict Swiss typographic rhythm.",
      behavioral_insight: "Engineered high chromatic contrast and golden-ratio proportions to foster instant brand recall and effortless readability.",
      tags: "Branding, Typography, Visual Identity, Design System"
    },
    "es" => {
      title: "Yorrany",
      client: "Yorrany Braga",
      role: "Estrategia de Marca",
      period: "Ago 2024",
      tagline: "Identidad Visual Autoral y Sistema Tipográfico",
      summary: "Sistema de identidad visual autoral y tipografía personalizada que une diseño de producto, psicología cognitiva e ingeniería de software.",
      full_description: "Desarrollo de la marca autoral Yorrany, Design System con tokens para modo claro/oscuro y estándares visuales internacionales.",
      challenge: "Sintetizar 20 años de trayectoria multidisciplinaria en una identidad atemporal, precisa y humana.",
      solution: "Monograma geométrico limpio, azul eléctrico emblemático (#003CA5) y estructura tipográfica suiza rigurosa.",
      behavioral_insight: "Alto contraste cromático y proporciones armónicas para fijar la marca en la memoria y brindar máxima legibilidad.",
      tags: "Branding, Tipografía, Identidad Visual, Design System"
    }
  },
  8 => {
    "pt-PT" => {
      title: "Jungle Nutri",
      client: "Jungle Nutri",
      role: "Estratégia de Marca",
      period: "Jul 2025",
      tagline: "Identidade de Marca & Embalagens Sustentáveis",
      summary: "Design de embalagens e arquitetura de marca para produtos de nutrição sustentável e ingredientes botânicos da Amazônia.",
      full_description: "Criação de linha de rótulos, ilustrações botânicas vetorizadas, materiais promocionais de ponto de venda e estratégia de embalagem eco-friendly.",
      challenge: "Destacar produtos amazônicos no mercado global de saúde e suplementos com sofisticação e apelo ecológico genuíno.",
      solution: "Ilustrações científicas refinadas, paleta inspirada na biodiversidade da floresta e rotulagem clara destacando benefícios funcionais.",
      behavioral_insight: "Uso de cores terrosas e verdes profundos associados à pureza biológica para gerar credibilidade e preferência de marca.",
      tags: "Packaging, Identidade de Marca, Design Sustentável, Branding"
    },
    "en" => {
      title: "Jungle Nutri",
      client: "Jungle Nutri",
      role: "Brand Strategy",
      period: "Jul 2025",
      tagline: "Brand Identity & Sustainable Nutrition Packaging",
      summary: "Packaging system and brand architecture for Amazonian sustainable health and botanical nutrition products.",
      full_description: "Product label line, custom vector botanical illustrations, retail point-of-sale displays, and eco-conscious packaging specifications.",
      challenge: "Elevate Amazonian superfoods in the competitive global wellness market with authentic sustainability credentials and premium aesthetics.",
      solution: "Refined scientific flora illustrations, earthy natural color palette, and clean typography highlighting organic provenance.",
      behavioral_insight: "Leveraged organic green and earthy tones to trigger subconscious associations with bio-purity and wellness efficacy.",
      tags: "Packaging, Brand Identity, Sustainable Design, Branding"
    },
    "es" => {
      title: "Jungle Nutri",
      client: "Jungle Nutri",
      role: "Estrategia de Marca",
      period: "Jul 2025",
      tagline: "Identidad de Marca y Empaques Sostenibles",
      summary: "Diseño de packaging y arquitectura de marca para productos de nutrición sostenible con ingredientes botánicos amazónicos.",
      full_description: "Línea de empaques, ilustraciones botánicas personalizadas, material para punto de venta y packaging ecológico.",
      challenge: "Posicionar superalimentos amazónicos en el mercado global de bienestar con sofisticación y sostenibilidad real.",
      solution: "Ilustraciones botánicas detalladas, paleta natural y tipografía limpia destacando el origen orgánico.",
      behavioral_insight: "Tonos verdes y terrosos para generar asociaciones automáticas de pureza biológica y salud natural.",
      tags: "Packaging, Identidad de Marca, Diseño Sostenible, Branding"
    }
  },
  9 => {
    "pt-PT" => {
      title: "Geostrauss",
      client: "Geostrauss",
      role: "Estratégia Digital",
      period: "Ago 2024",
      tagline: "Estratégia de Conteúdo Visual & Motion Design",
      summary: "Criação de identidade audiovisual e peças dinâmicas de engenharia e geotecnia para autoridade digital e prospecção técnica.",
      full_description: "Vinhetas em motion design, infográficos técnicos animados sobre obras de infraestrutura, vídeos institucionais e templates para apresentações de projetos de grande porte.",
      challenge: "Tornar conceitos geotécnicos complexos e dados de engenharia visualmente atraentes e compreensíveis para tomadores de decisão.",
      solution: "Animações em 2D/3D com esquemas técnicos precisos, paleta sóbria de alto contraste e motion graphics fluidos.",
      behavioral_insight: "Simplificação cognitiva através de microanimações em etapas consecutivas para retenção em apresentações técnicas.",
      tags: "Motion Design, Conteúdo Visual, Estratégia Digital, Engenharia"
    },
    "en" => {
      title: "Geostrauss",
      client: "Geostrauss",
      role: "Digital Strategist",
      period: "Aug 2024",
      tagline: "Visual Content Strategy & Motion Design",
      summary: "Dynamic audiovisual content system and motion design for geotechnical engineering authority and client presentations.",
      full_description: "Motion graphics branding, animated technical infrastructure infographics, corporate videos, and high-impact pitch decks for large infrastructure bids.",
      challenge: "Transform complex geotechnical data and specialized engineering blueprints into engaging, persuasive visual narratives.",
      solution: "Clean 2D/3D motion graphics, precision-engineered technical schematic overlays, and streamlined executive presentation kits.",
      behavioral_insight: "Chunked complex data into staged sequential micro-animations to improve executive cognitive retention during pitch meetings.",
      tags: "Motion Design, Visual Content, Digital Strategy, Engineering"
    },
    "es" => {
      title: "Geostrauss",
      client: "Geostrauss",
      role: "Estrategia Digital",
      period: "Ago 2024",
      tagline: "Estrategia de Contenido Visual y Motion Design",
      summary: "Creación de identidad audiovisual y piezas de ingeniería y geotecnia para autoridad digital y propuestas técnicas.",
      full_description: "Motion design corporativo, infografías animadas sobre infraestructura, videos explicativos y plantillas para proyectos de gran escala.",
      challenge: "Hacer comprensibles y visualmente atractivos los conceptos geotécnicos y datos de ingeniería para directivos y tomadores de decisiones.",
      solution: "Animaciones 2D/3D con esquemas técnicos precisos, alto contraste y gráficos en movimiento fluidos.",
      behavioral_insight: "Fragmentación de información compleja en microanimaciones progresivas para maximizar la retención en reuniones ejecutivas.",
      tags: "Motion Design, Contenido Visual, Estrategia Digital, Ingeniería"
    }
  },
  10 => {
    "pt-PT" => {
      title: "CogniBox",
      client: "CogniBox",
      role: "Product Design",
      period: "Jul 2024",
      tagline: "E-Commerce & Ferramentas para Psicopedagogia",
      summary: "Plataforma de comércio digital e materiais educativos integrando psicologia cognitiva, avaliação de aprendizagem e design de produto.",
      full_description: "Arquitetura de informação do e-commerce, desenho de jogos cognitivos físicos e digitais, dashboard de compras para terapeutas e educadores.",
      challenge: "Desenvolver uma plataforma de compras que atendesse tanto a profissionais de saúde exigentes quanto a pais buscando recursos pedagógicos.",
      solution: "Categorização por faixa etária e habilidade cognitiva (atenção, memória, linguagem), checkout rápido e design visual lúdico porém confiável.",
      behavioral_insight: "Filtros heurísticos orientados a objetivos terapêuticos específicos, diminuindo o tempo de busca e aumentando a conversão.",
      tags: "Product Design, E-Commerce, Psicologia Cognitiva, UI/UX"
    },
    "en" => {
      title: "CogniBox",
      client: "CogniBox",
      role: "Product Design",
      period: "Jul 2024",
      tagline: "E-Commerce & Cognitive Tools Platform",
      summary: "Digital commerce platform and educational products blending cognitive psychology, assessment frameworks, and product design.",
      full_description: "E-commerce information architecture, physical and digital cognitive toolkits design, and therapist/educator procurement dashboards.",
      challenge: "Build an intuitive shopping experience serving both clinical psychologists and parents seeking structured developmental tools.",
      solution: "Faceted taxonomy categorized by developmental skill (memory, attention, spatial reasoning), one-click purchasing, and clean trustworthy UI.",
      behavioral_insight: "Goal-oriented heuristic filtering aligned with clinical objectives, reducing search fatigue and boosting purchase completion.",
      tags: "Product Design, E-Commerce, Cognitive Psychology, UI/UX"
    },
    "es" => {
      title: "CogniBox",
      client: "CogniBox",
      role: "Diseño de Producto",
      period: "Jul 2024",
      tagline: "Comercio Electrónico y Herramientas Cognitivas",
      summary: "Plataforma de comercio electrónico y materiales educativos que integran psicología cognitiva, evaluación y diseño de producto.",
      full_description: "Arquitectura de información para e-commerce, diseño de kits cognitivos y panel de compras para terapeutas y educadores.",
      challenge: "Crear una experiencia de compra clara para psicólogos clínicos y familias en búsqueda de herramientas psicopedagógicas.",
      solution: "Filtros organizados por habilidades cognitivas (atención, memoria, lenguaje), checkout ágil y diseño lúdico y confiable.",
      behavioral_insight: "Filtros heurísticos orientados a metas terapéuticas para reducir la fatiga de búsqueda y aumentar la conversión.",
      tags: "Diseño de Producto, E-Commerce, Psicología Cognitiva, UI/UX"
    }
  },
  11 => {
    "pt-PT" => {
      title: "Dra. Priscilla Lima",
      client: "Dra. Priscilla Lima",
      role: "Estratégia de Marca",
      period: "Jan 2024",
      tagline: "Posicionamento de Marca & Identidade Visual Médica",
      summary: "Identidade visual para consultório médico de alta reputação, equilibrando empatia humana, sobriedade clínica e excelência profissional.",
      full_description: "Branding médico completo, papelaria de receituários com segurança visual, sinalização de clínica e materiais de orientação ao paciente.",
      challenge: "Desenvolver uma identidade médica acolhedora sem cair em clichês genéricos da área de saúde, transmitindo inovação e cuidado.",
      solution: "Símbolo baseado em formas orgânicas fluidas, tons azuis e esmeralda profundos e tipografia com excelente legibilidade para pacientes.",
      behavioral_insight: "Paleta cromática calmante e tipografia sem serifa para reduzir a ansiedade pré-consulta e fortalecer o vínculo médico-paciente.",
      tags: "Estratégia de Marca, Branding Médico, Identidade Visual"
    },
    "en" => {
      title: "Dra. Priscilla Lima",
      client: "Dra. Priscilla Lima",
      role: "Brand Strategy",
      period: "Jan 2024",
      tagline: "Medical Visual Identity & Brand Positioning",
      summary: "Premium visual identity for a specialized medical clinic, harmonizing human empathy, clinical rigor, and medical excellence.",
      full_description: "End-to-end healthcare branding, prescription security stationery, clinic interior environmental wayfinding, and patient care guidance booklets.",
      challenge: "Create a compassionate healthcare brand that sidesteps generic medical clichés while conveying cutting-edge clinical rigor.",
      solution: "Fluid organic emblem, calming oceanic and emerald tones, and highly legible typography tailored for patient reassurance.",
      behavioral_insight: "Therapeutic color psychology and humanist sans-serif typefaces to mitigate pre-appointment anxiety and reinforce patient trust.",
      tags: "Brand Strategy, Medical Branding, Visual Identity"
    },
    "es" => {
      title: "Dra. Priscilla Lima",
      client: "Dra. Priscilla Lima",
      role: "Estrategia de Marca",
      period: "Ene 2024",
      tagline: "Identidad Visual Médica y Posicionamiento de Marca",
      summary: "Identidad visual para consultorio médico de alta reputación, combinando empatía humana, rigor clínico y excelencia profesional.",
      full_description: "Branding médico completo, papelería médica con seguridad visual, señalización de clínica y folletos de atención al paciente.",
      challenge: "Crear una identidad médica cercana que evite lugares comunes y comunique innovación y cuidado integral.",
      solution: "Símbolo orgánico fluido, tonos azul y esmeralda calmantes y tipografía de máxima legibilidad.",
      behavioral_insight: "Psicología cromática relajante para reducir la ansiedad previa a la consulta y consolidar la confianza médica.",
      tags: "Estrategia de Marca, Branding Médico, Identidad Visual"
    }
  },
  12 => {
    "pt-PT" => {
      title: "Itam",
      client: "ITAM",
      role: "Estratégia Digital",
      period: "Jul 2024",
      tagline: "Comunicação Digital & Estratégia de Redes Sociais",
      summary: "Sistema de peças e planejamento de comunicação digital para engajamento comunitário, projetos de impacto e eventos institucionais.",
      full_description: "Estratégia de comunicação multiplataforma, templates reutilizáveis para campanhas sociais, relatórios de impacto visualmente ricos e cobertura de eventos.",
      challenge: "Engajar públicos diversos em torno de causas sociais e institucionais mantendo alto rigor estético e velocidade de publicação.",
      solution: "Kit de design modular para redes sociais, paleta vibrante com alto contraste e tipografia de forte impacto visual.",
      behavioral_insight: "Uso de infográficos narrativos e gatilhos de reciprocidade para aumentar o compartilhamento orgânico de campanhas comunitárias.",
      tags: "Estratégia Digital, Social Media, Engajamento, Branding"
    },
    "en" => {
      title: "Itam",
      client: "ITAM",
      role: "Digital Strategist",
      period: "Jul 2024",
      tagline: "Digital Communication & Social Strategy",
      summary: "Digital content design and multi-channel communication strategy for community engagement, impact initiatives, and events.",
      full_description: "Cross-platform communications architecture, modular social campaign design kits, data-rich annual impact reports, and event coverage collateral.",
      challenge: "Mobilize diverse community audiences around social initiatives while sustaining high aesthetic standards and rapid publishing cadence.",
      solution: "Modular social media toolkit, high-contrast dynamic color palette, and bold typographic hierarchy for fast recognition in feeds.",
      behavioral_insight: "Narrative data visualizations paired with reciprocity cues to maximize organic sharing and community mobilization.",
      tags: "Digital Strategy, Social Media, Engagement, Branding"
    },
    "es" => {
      title: "Itam",
      client: "ITAM",
      role: "Estrategia Digital",
      period: "Jul 2024",
      tagline: "Comunicación Digital y Estrategia de Redes Sociales",
      summary: "Diseño de contenido digital y estrategia de comunicación para engagement comunitario, impacto social y eventos.",
      full_description: "Estrategia multicanal, plantillas modulares para campañas comunitarias, informes de impacto visuales y cobertura de eventos.",
      challenge: "Movilizar audiencias diversas hacia iniciativas sociales con alto nivel visual y velocidad de publicación.",
      solution: "Kit modular de diseño para redes, colores dinámicos de alto contraste y tipografía contundente.",
      behavioral_insight: "Infografías narrativas para estimular el compromiso emocional y aumentar la difusión orgánica de campañas.",
      tags: "Estrategia Digital, Redes Sociales, Engagement, Branding"
    }
  },
  13 => {
    "pt-PT" => {
      title: "Grid Comercial",
      client: "Grid Comercial",
      role: "Design Gráfico",
      period: "Jul 2024",
      tagline: "Design de Informação & Peças Corporativas",
      summary: "Estruturação de materiais gráficos de planejamento comercial e tabelas de dados para tomada de decisão e vendas B2B.",
      full_description: "Diagramação de relatórios comerciais, infográficos de mercado, catálogos de fornecedores e guias de produto para equipe comercial externa.",
      challenge: "Transformar tabelas financeiras e fluxos de vendas complexos em materiais legíveis, elegantes e práticos para negociações presenciais.",
      solution: "Sistemas de grelhas rigorosos, hierarquia de pesos tipográficos e codificação cromática funcional para leitura rápida de métricas.",
      behavioral_insight: "Aplicação do Efeito de Posição Serial em tabelas de preços e comparativos para direcionar o foco às opções de maior rentabilidade.",
      tags: "Design de Informação, Design Gráfico, Editorial, Grids"
    },
    "en" => {
      title: "Grid Comercial",
      client: "Grid Comercial",
      role: "Graphic Design",
      period: "Jul 2024",
      tagline: "Information Design & Corporate Collateral",
      summary: "Information architecture and print design systems for corporate sales planning, B2B product catalogs, and data sheets.",
      full_description: "Financial performance reports layout, market data infographics, vendor directories, and sales enablement presentation decks for enterprise teams.",
      challenge: "Turn dense financial spreadsheets and sales pipeline matrices into highly legible, elegant, and action-oriented sales collateral.",
      solution: "Structured grid system, typographic weight hierarchy, and functional color coding for effortless metric scanning in business meetings.",
      behavioral_insight: "Applied the Serial Position Effect across price comparison charts to anchor executive attention on high-yield solution tiers.",
      tags: "Information Design, Graphic Design, Editorial, Grids"
    },
    "es" => {
      title: "Grid Comercial",
      client: "Grid Comercial",
      role: "Diseño Gráfico",
      period: "Jul 2024",
      tagline: "Diseño de Información y Materiales Corporativos",
      summary: "Estructuración de piezas gráficas de planificación comercial y retículas de datos para toma de decisiones y ventas B2B.",
      full_description: "Maquetación de informes comerciales, infografías de mercado, catálogos de proveedores y manuales de ventas empresariales.",
      challenge: "Convertir datos comerciales complejos y matrices financieras en documentos claros, elegantes y efectivos para negociaciones.",
      solution: "Retículas estructuradas, jerarquía tipográfica precisa y codificación de color funcional para lectura rápida.",
      behavioral_insight: "Uso del Efecto de Posición Serial en tablas comparativas para destacar las soluciones de mayor rentabilidad.",
      tags: "Diseño de Información, Diseño Gráfico, Editorial, Retículas"
    }
  },
  14 => {
    "pt-PT" => {
      title: "Espaço Caboquinho",
      client: "Espaço Caboquinho",
      role: "Estratégia de Marca",
      period: "Ago 2024",
      tagline: "Identidade de Marca Regional & Marketing Visual",
      summary: "Reposicionamento de marca e direção visual valorizando a cultura local com linguagem contemporânea e comunicação envolvente.",
      full_description: "Redesenho de logotipo, cardápios impressos e digitais, sinalização de ambiente, embalagens para viagem e estratégia de presença digital.",
      challenge: "Equilibrar raízes culturais regionais com uma apresentação moderna e atrativa para turistas e moradores da cidade.",
      solution: "Grafismos inspirados no artesanato e natureza local, paleta de cores quentes e tipografia amigável e expressiva.",
      behavioral_insight: "Uso de narrativas visuais de pertencimento e aconchego para criar laços emocionais duradouros com a clientela.",
      tags: "Estratégia de Marca, Cultura Regional, Marketing Visual"
    },
    "en" => {
      title: "Espaço Caboquinho",
      client: "Espaço Caboquinho",
      role: "Brand Strategy",
      period: "Aug 2024",
      tagline: "Regional Brand Identity & Visual Marketing",
      summary: "Brand repositioning and visual direction celebrating local cultural heritage through contemporary aesthetic standards.",
      full_description: "Logo redesign, physical and QR-code menus, environmental interior signage, eco-friendly takeout packaging, and local digital marketing strategy.",
      challenge: "Harmonize traditional cultural heritage with a fresh, contemporary aesthetic appealing to both tourists and local culinary enthusiasts.",
      solution: "Custom cultural pattern motifs, warm organic palette, and vibrant expressive typography.",
      behavioral_insight: "Wove visual storytelling of authentic local roots and culinary craft to build an emotional connection and word-of-mouth loyalty.",
      tags: "Brand Strategy, Regional Culture, Visual Marketing"
    },
    "es" => {
      title: "Espaço Caboquinho",
      client: "Espaço Caboquinho",
      role: "Estrategia de Marca",
      period: "Ago 2024",
      tagline: "Identidad de Marca Regional y Marketing Visual",
      summary: "Reposicionamiento de marca y dirección visual celebrando la cultura local con un lenguaje contemporáneo y atractivo.",
      full_description: "Rediseño de logotipo, cartas impresas y digitales, señalización de local, empaques para llevar y estrategia en redes sociales.",
      challenge: "Equilibrar la autenticidad regional con una presentación moderna para el público local y turistas.",
      solution: "Patrones gráficos inspirados en la naturaleza local, colores cálidos y tipografía expresiva.",
      behavioral_insight: "Narrativa visual de pertenencia y calidez para generar vínculos emocionales y fidelidad de los clientes.",
      tags: "Estrategia de Marca, Cultura Regional, Marketing Visual"
    }
  },
  15 => {
    "pt-PT" => {
      title: "Trabalhos Selecionados",
      client: "Clientes Diversos",
      role: "Design Gráfico",
      period: "Jul 2021",
      tagline: "Coleção de Peças Gráficas & Impressos Promocionais",
      summary: "Acervo de direção de arte, posters, flyers e materiais promocionais com exploração tipográfica e composições de alto impacto.",
      full_description: "Compilação de trabalhos de publicidade, cartazes culturais, capas de álbuns, flyers de eventos e experimentos visuais autorais realizados para diversos clientes ao longo da trajetória profissional.",
      challenge: "Demonstrar versatilidade estilística, agilidade criativa e domínio técnico de composição em projetos com diferentes orçamentos e prazos.",
      solution: "Seleção curada de peças de alto contraste, tipografia ousada e uso expressivo de cores e texturas visuais.",
      behavioral_insight: "Composições dinâmicas assimétricas para romper a monotonia visual e capturar a atenção imediata do espectador.",
      tags: "Design Gráfico, Direção de Arte, Impressos, Publicidade"
    },
    "en" => {
      title: "Selected Works",
      client: "Various Clients",
      role: "Graphic Design",
      period: "Jul 2021",
      tagline: "Print Design & Promotional Artwork Collection",
      summary: "Curated collection of art direction, posters, and print collateral exploring expressive typography and bold visual compositions.",
      full_description: "Compilation of advertising posters, cultural event collateral, album artwork, flyers, and authorial visual experiments developed for various clients across two decades of practice.",
      challenge: "Demonstrate stylistic versatility, rapid creative execution, and deep technical mastery across varied production constraints and timelines.",
      solution: "Curated anthology of high-contrast compositions, bold typography, and expressive interplay of color, grain, and photography.",
      behavioral_insight: "Asymmetrical tension and focal focal points designed to disrupt visual monotony and command instant viewing engagement.",
      tags: "Graphic Design, Art Direction, Print Design, Advertising"
    },
    "es" => {
      title: "Trabajos Seleccionados",
      client: "Varios Clientes",
      role: "Diseño Gráfico",
      period: "Jul 2021",
      tagline: "Colección de Piezas Gráficas e Impresos Promocionales",
      summary: "Colección de dirección de arte, carteles y materiales impresos explorando tipografía expresiva y composiciones de alto impacto.",
      full_description: "Compilación de carteles publicitarios, piezas culturales, portadas de discos y experimentos visuales desarrollados para diversos clientes.",
      challenge: "Demostrar versatilidad estilística y dominio técnico de composición en proyectos con diferentes requerimientos.",
      solution: "Selección cuidada de piezas de alto contraste, tipografía contundente y uso expresivo del color.",
      behavioral_insight: "Composiciones dinámicas asimétricas para romper la monotonía y capturar la atención inmediata.",
      tags: "Diseño Gráfico, Dirección de Arte, Impresos, Publicidad"
    }
  },
  16 => {
    "pt-PT" => {
      title: "Tupinside",
      client: "Tupinside",
      role: "Publicidade",
      period: "Set 2024",
      tagline: "Campanha Publicitária & Identidade Visual Criativa",
      summary: "Criação de campanha publicitária com storytelling visual e direção de arte para engajamento de marca e visibilidade no mercado.",
      full_description: "Conceito criativo de campanha integrada, key visuals para outdoors e mídias digitais, direção de arte fotográfica e peças promocionais.",
      challenge: "Construir uma campanha que se destacasse no concorrido mercado de entretenimento com mensagem marcante e estética memorável.",
      solution: "Narrativa centrada na vivência sensorial, tipografia ousada com cortes estilizados e fotografia de alto dinamismo.",
      behavioral_insight: "Uso do efeito de Contraste de Von Restorff para fazer com que os elementos visuais principais se sobressaiam instantaneamente.",
      tags: "Publicidade, Storytelling Visual, Estratégia de Campanha"
    },
    "en" => {
      title: "Tupinside",
      client: "Tupinside",
      role: "Advertising",
      period: "Sep 2024",
      tagline: "Creative Advertising Campaign & Visual Identity",
      summary: "Advertising campaign creation with visual storytelling and striking art direction for maximum brand visibility and resonance.",
      full_description: "Integrated campaign creative concept, key visuals for outdoor billboards and social channels, photographic art direction, and promotional collateral.",
      challenge: "Design a break-through campaign in the crowded entertainment space with an instantly memorable visual punch.",
      solution: "Narrative grounded in sensorial human experiences, bold customized typography, and dynamic high-energy photography.",
      behavioral_insight: "Harnessed the Von Restorff Effect to make campaign key visuals pop against urban background noise and busy social feeds.",
      tags: "Advertising, Visual Storytelling, Campaign Strategy"
    },
    "es" => {
      title: "Tupinside",
      client: "Tupinside",
      role: "Publicidad",
      period: "Sep 2024",
      tagline: "Campaña Publicitaria e Identidad Visual Creativa",
      summary: "Creación de campaña publicitaria con narrativa visual y dirección de arte para posicionamiento de marca y visibilidad.",
      full_description: "Concepto creativo de campaña integrada, key visuals para vallas y medios digitales, dirección fotográfica y piezas promocionales.",
      challenge: "Construir una campaña que destaque en el mercado de entretenimiento con un mensaje memorable y estética impactante.",
      solution: "Narrativa sensorial, tipografía personalizada y fotografía dinámica de alto impacto.",
      behavioral_insight: "Uso del Efecto Von Restorff para que los elementos visuales principales resalten de inmediato en el entorno urbano y digital.",
      tags: "Publicidad, Storytelling Visual, Estrategia de Campaña"
    }
  }
}

case_studies_data.each do |id, translations|
  cs = CaseStudy.find_by(id: id)
  next unless cs

  title_pt = translations.dig("pt-PT", :title) || translations.dig("pt-BR", :title) || translations.values.first[:title]
  puts "Sincronizando CaseStudy ##{id} (#{title_pt})..."

  translations.each do |locale, attrs|
    target_locale = (locale.to_s == "pt-BR" ? :"pt-PT" : locale.to_sym)
    Mobility.with_locale(target_locale) do
      attrs.each do |attr_name, val|
        if cs.respond_to?("#{attr_name}=")
          cs.public_send("#{attr_name}=", val)
        end
      end
    end
  end

  cs.skip_auto_translate = true
  cs.save(validate: false)
end

puts "\n✔ Todos os 16 Estudos de Caso foram harmonizados com sucesso em PT-PT, EN e ES!"
