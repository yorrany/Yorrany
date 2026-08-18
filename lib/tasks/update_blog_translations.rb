# frozen_string_literal: true

# Script para atualizar e garantir as traduções do Blog em todos os locales
def update_blog_posts!
  puts "Atualizando traduções dos artigos do Blog..."

  # 1. Post: psicologia-design-interfaces
  p1 = Post.find_or_initialize_by(slug: "psicologia-design-interfaces")
  p1.published_at ||= Time.zone.parse("2026-08-13 19:25:40")
  p1.skip_auto_translate = true

  Mobility.with_locale(:"pt-PT") do
    p1.title = "A Psicologia no Design de Interfaces: Da Atenção à Ação"
    p1.excerpt = "Como microdecisões no design guiam o comportamento humano, reduzem a carga cognitiva e aumentam a conversão de forma ética."
    p1.content = <<~MD
      No desenvolvimento de produtos digitais, o design vai muito além da estética visual. Cada elemento posicionado num ecrã estabelece um diálogo cognitivo direto com quem o utiliza.

      ### A Lei de Hick e a Carga Cognitiva
      Quando oferecemos demasiadas opções simultâneas, o tempo de resposta e a taxa de desistência aumentam exponencialmente. Reduzir escolhas secundárias e focar na ação primária não é apenas minimalismo: é respeito pela atenção humana.

      ### O Poder dos Modelos Mentais
      Os utilizadores passam a maior parte do tempo noutros produtos. Trazer consistência de padrões e previsibilidade de navegação permite que a pessoa foque no que realmente importa: a conclusão da sua tarefa sem atrito.

      ### Ética Comportamental e Confiança
      O verdadeiro design de produto utiliza insights psicológicos para capacitar o utilizador, criando relações de longo prazo baseadas na clareza, transparência e confiança.
    MD
  end

  Mobility.with_locale(:en) do
    p1.title = "The Psychology of Interface Design: From Attention to Action"
    p1.excerpt = "How subtle decisions in interface design guide human behavior, reduce cognitive load, and drive conversion ethically."
    p1.content = <<~MD
      In digital product development, design goes far beyond aesthetics. Every element placed on a screen establishes a direct cognitive dialogue with the user.

      ### Hick's Law and Cognitive Load
      When we present too many choices at once, response time and drop-off rates increase exponentially. Eliminating secondary friction and focusing on the primary action is not just minimalism: it is respect for human attention.

      ### The Power of Mental Models
      Users spend most of their time using other products. Leveraging familiar patterns and navigational predictability allows people to focus on what truly matters: completing their tasks without friction.

      ### Behavioral Ethics and Trust
      True product design uses psychological insights to empower the user, establishing long-term relationships built on clarity, transparency, and trust.
    MD
  end

  Mobility.with_locale(:es) do
    p1.title = "La Psicología en el Diseño de Interfaces: De la Atención a la Acción"
    p1.excerpt = "Cómo las microdecisiones en la interfaz guían la conducta humana, reducen la carga cognitiva y aumentan la conversión de forma ética."
    p1.content = <<~MD
      En el desarrollo de productos digitales, el diseño va mucho más allá de la estética. Cada elemento posicionado en pantalla establece un diálogo cognitivo directo con el usuario.

      ### La Ley de Hick y la Carga Cognitiva
      Cuando ofrecemos demasiadas opciones simultáneas, el tiempo de respuesta y la tasa de abandono aumentan exponencialmente. Reducir la fricción secundaria y priorizar la acción principal no es solo minimalismo: es respeto por la atención humana.

      ### El Poder de los Modelos Mentales
      Los usuarios pasan la mayor parte de su tiempo en otros productos. Mantener la coherencia de patrones y la predictibilidad permite que las personas se concentren en lo que realmente importa: completar sus objetivos sin fricciones.

      ### Ética del Comportamiento y Confianza
      El verdadero diseño de producto utiliza insights psicológicos para empoderar al usuario, construyendo relaciones a largo plazo basadas en la claridad, la transparencia y la confianza.
    MD
  end

  p1.save!
  puts "✓ Post 1 (psicologia-design-interfaces) atualizado nos 3 idiomas."

  # 2. Post: design-system-muito-alem
  p2 = Post.find_or_initialize_by(slug: "design-system-muito-alem")
  p2.published_at ||= Time.zone.parse("2026-08-13 19:25:40")
  p2.skip_auto_translate = true

  Mobility.with_locale(:"pt-PT") do
    p2.title = "Design System: Muito Além dos Componentes"
    p2.excerpt = "Por que um Design System eficiente é sobre comunicação e alinhamento estratégico, não apenas botões e paletas de cores."
    p2.content = <<~MD
      Quando falamos em Design Systems, a primeira imagem que costuma surgir é uma biblioteca do Figma com botões, inputs e paletas de cores milimetricamente organizadas. No entanto, componentes visuais são apenas a ponta do iceberg.

      ### O Design System como Linguagem Compartilhada
      Um Design System maduro funciona primordialmente como um contrato de comunicação entre Design, Engenharia e Produto. Ele estabelece uma gramática comum através de Design Tokens semânticos, garantindo consistência e acelerando o ciclo de entrega de novas funcionalidades.

      ### Governança e Escalabilidade
      Sem processos claros de contribuição e governança, qualquer biblioteca de componentes torna-se obsoleta rapidamente. O sucesso de um sistema mede-se pela sua adoção ativa nas equipas e pela capacidade de evoluir sem quebrar a experiência do utilizador.

      ### Da Decisão Visual ao Código de Produção
      A verdadeira maturidade surge quando os tokens de design alimentam diretamente a arquitetura de Front-End, criando um ecossistema sincronizado onde uma alteração de marca propaga-se com segurança e precisão para produção.
    MD
  end

  Mobility.with_locale(:en) do
    p2.title = "Design Systems: Far Beyond UI Components"
    p2.excerpt = "Why an effective Design System is about strategic communication and organizational alignment, not just buttons and colors."
    p2.content = <<~MD
      When we talk about Design Systems, the first image that comes to mind is often a Figma library filled with buttons, input fields, and color swatches. However, visual UI components are only the tip of the iceberg.

      ### The Design System as a Shared Language
      A mature Design System functions primarily as a communication contract between Design, Engineering, and Product. It establishes a shared grammar through semantic Design Tokens, driving consistency and accelerating time-to-market for new features.

      ### Governance and Scalability
      Without clear contribution and governance models, any component library quickly degrades. The true measure of a system's success is its active adoption across squads and its resilience to evolve without breaking the user experience.

      ### From Visual Decisions to Production Code
      True maturity happens when design tokens feed directly into the Front-End architecture, creating a synchronized ecosystem where brand updates propagate reliably and effortlessly to production.
    MD
  end

  Mobility.with_locale(:es) do
    p2.title = "Design System: Mucho Más Allá de los Componentes"
    p2.excerpt = "Por qué un Design System eficiente trata sobre comunicación y alineación estratégica, no solo botones y colores."
    p2.content = <<~MD
      Cuando hablamos de Design Systems, la primera imagen que suele surgir es una librería de Figma con botones, campos de texto y paletas de colores. Sin embargo, los componentes visuales son solo la punta del iceberg.

      ### El Design System como Lenguaje Compartido
      Un Design System maduro funciona primordialmente como un contrato de comunicación entre Diseño, Ingeniería y Producto. Establece una gramática común a través de Design Tokens semánticos, garantizando consistencia y acelerando la entrega de valor.

      ### Gobernanza y Escalabilidad
      Sin procesos claros de contribución y gobernanza, cualquier librería de componentes queda obsoleta con rapidez. El éxito de un sistema se mide por su adopción activa en los equipos y su capacidad de evolucionar sin fricciones para el usuario final.

      ### De la Decisión Visual al Código en Producción
      La verdadera madurez ocurre cuando los design tokens alimentan directamente la arquitectura de Front-End, creando un ecosistema sincronizado donde cada cambio de marca se propaga con total seguridad a producción.
    MD
  end

  p2.save!
  puts "✓ Post 2 (design-system-muito-alem) atualizado nos 3 idiomas."
end

update_blog_posts!
