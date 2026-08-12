require_relative '../config/environment'

Certification.all.each do |c|
  pt_skills = c.attributes['skills']
  next unless pt_skills
  
  Mobility.with_locale(:'pt-BR') { c.skills = pt_skills }
  Mobility.with_locale(:'pt-PT') { c.skills = pt_skills }
  
  # very basic translations for the known skills just to fix the immediate issue
  en_skills = pt_skills.gsub('Programação lógica', 'Logic Programming')
                       .gsub('Lógica de Programação', 'Programming Logic')
                       .gsub('Estrutura de Dados', 'Data Structures')
                       .gsub('Publicidade em Mídias Sociais', 'Social Media Advertising')
                       .gsub('Criação de Campanhas de Marketing', 'Marketing Campaign Creation')
                       .gsub('Engajamento', 'Engagement')
                       .gsub('Métricas de Marketing Digital', 'Digital Marketing Metrics')
                       .gsub('Análise de Dados', 'Data Analysis')
                       .gsub('Otimização de Performance', 'Performance Optimization')
                       .gsub('Proposta de Valor', 'Value Proposition')
                       .gsub('Estratégia Empresarial', 'Business Strategy')
                       .gsub('Posicionamento de Mercado', 'Market Positioning')
                       .gsub('Análise de Concorrência', 'Competitor Analysis')
                       .gsub('Metodologias Ágeis', 'Agile Methodologies')
                       .gsub('Prototipagem Rápida', 'Rapid Prototyping')
                       .gsub('Transformação Digital', 'Digital Transformation')
                       .gsub('Resolução de Problemas', 'Problem Solving')
                       .gsub('Inteligência Artificial', 'Artificial Intelligence')
                       .gsub('Ferramentas de IA Generativa', 'Generative AI Tools')
                       .gsub('Design de Interfaces', 'Interface Design')
                       .gsub('Fluxo Creativo com IA', 'Creative Workflow with AI')
                       .gsub('Avaliação Psicológica', 'Psychological Assessment')
                       .gsub('Análise Comportamental', 'Behavioral Analysis')
                       .gsub('Diagnóstico', 'Diagnosis')
                       .gsub('Psicologia Aplicada', 'Applied Psychology')
                       .gsub('Produtividade', 'Productivity')
                       .gsub('Gestão de Carreira', 'Career Management')
                       .gsub('Autogestão', 'Self Management')
                       .gsub('Planejamento Estratégico Pessoal', 'Personal Strategic Planning')
                       .gsub('Liderança', 'Leadership')
                       .gsub('Psicologia Organizacional', 'Organizational Psychology')
                       .gsub('Saúde Mental no Trabalho', 'Mental Health at Work')
                       .gsub('Comportamento Humano', 'Human Behavior')
                       .gsub('Gestão de Clima', 'Climate Management')
                       .gsub('Pesquisa com Usuários', 'User Research')
                       .gsub('Arquitetura de Informação', 'Information Architecture')
                       .gsub('Prototipagem', 'Prototyping')
                       
  Mobility.with_locale(:en) { c.skills = en_skills }
  
  es_skills = pt_skills.gsub('Programação lógica', 'Programación Lógica')
                       .gsub('Lógica de Programação', 'Lógica de Programación')
                       .gsub('Estrutura de Dados', 'Estructuras de Datos')
                       .gsub('Publicidade em Mídias Sociais', 'Publicidad en Redes Sociales')
                       .gsub('Criação de Campanhas de Marketing', 'Creación de Campañas de Marketing')
                       .gsub('Engajamento', 'Compromiso')
                       .gsub('Métricas de Marketing Digital', 'Métricas de Marketing Digital')
                       .gsub('Análise de Dados', 'Análisis de Datos')
                       .gsub('Otimização de Performance', 'Optimización de Rendimiento')
                       .gsub('Proposta de Valor', 'Propuesta de Valor')
                       .gsub('Estratégia Empresarial', 'Estrategia Empresarial')
                       .gsub('Posicionamento de Mercado', 'Posicionamiento de Mercado')
                       .gsub('Análise de Concorrência', 'Análisis de Competencia')
                       .gsub('Metodologias Ágeis', 'Metodologías Ágiles')
                       .gsub('Prototipagem Rápida', 'Prototipado Rápido')
                       .gsub('Transformação Digital', 'Transformación Digital')
                       .gsub('Resolução de Problemas', 'Resolución de Problemas')
                       .gsub('Inteligência Artificial', 'Inteligencia Artificial')
                       .gsub('Ferramentas de IA Generativa', 'Herramientas de IA Generativa')
                       .gsub('Design de Interfaces', 'Diseño de Interfaces')
                       .gsub('Fluxo Creativo com IA', 'Flujo Creativo con IA')
                       .gsub('Avaliação Psicológica', 'Evaluación Psicológica')
                       .gsub('Análise Comportamental', 'Análisis de Comportamiento')
                       .gsub('Diagnóstico', 'Diagnóstico')
                       .gsub('Psicologia Aplicada', 'Psicología Aplicada')
                       .gsub('Produtividade', 'Productividad')
                       .gsub('Gestão de Carreira', 'Gestión de Carrera')
                       .gsub('Autogestão', 'Autogestión')
                       .gsub('Planejamento Estratégico Pessoal', 'Planificación Estratégica Personal')
                       .gsub('Liderança', 'Liderazgo')
                       .gsub('Psicologia Organizacional', 'Psicología Organizacional')
                       .gsub('Saúde Mental no Trabalho', 'Salud Mental en el Trabajo')
                       .gsub('Comportamento Humano', 'Comportamiento Humano')
                       .gsub('Gestão de Clima', 'Gestión de Clima')
                       .gsub('Pesquisa com Usuários', 'Investigación con Usuarios')
                       .gsub('Arquitetura de Informação', 'Arquitectura de Información')
                       .gsub('Prototipagem', 'Prototipado')
                       
  Mobility.with_locale(:es) { c.skills = es_skills }
  
  c.save!
end
