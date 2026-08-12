require_relative '../config/environment'

translations_en = {
  2 => { title: 'Programming: from abstraction to implementation in Python', category: 'Technology & Development', description: '' },
  1 => { title: 'Introduction to JavaScript Security (LFS184)', category: 'Technology & Development', description: '' },
  5 => { title: 'Social Media Marketing', category: 'E-commerce & Digital Strategy', description: '' },
  4 => { title: 'Analysis of Results in Digital Marketing', category: 'E-commerce & Digital Strategy', description: '' },
  3 => { title: 'Unique Value Proposition', category: 'Strategy & Business', description: '' },
  9 => { title: 'Design Sprint in Digital Transformation Projects', category: 'UX/UI & Product Design', description: '' },
  7 => { title: 'Masterclass: Artificial Intelligence in the designers routine', category: 'Innovation & AI', description: '' },
  14 => { title: 'Psychological Assessment in Manaus', category: 'Human Sciences', description: '' },
  6 => { title: 'Copilot: Master AI in Microsoft 365', category: 'Innovation & AI', description: '' },
  12 => { title: 'Career Plan', category: 'Management & Development', description: '' },
  11 => { title: 'Organizational Psychology', category: 'Management & Behavior', description: '' },
  10 => { title: 'UX Design Bootcamp for all', category: 'UX/UI & Product Design', description: '' }
}

translations_es = {
  2 => { title: 'Programación: de la abstracción a la implementación en Python', category: 'Tecnología y Desarrollo', description: '' },
  1 => { title: 'Introducción a la Seguridad de JavaScript (LFS184)', category: 'Tecnología y Desarrollo', description: '' },
  5 => { title: 'Marketing en Redes Sociales', category: 'E-commerce y Estrategia Digital', description: '' },
  4 => { title: 'Análisis de Resultados en Marketing Digital', category: 'E-commerce y Estrategia Digital', description: '' },
  3 => { title: 'Propuesta de Valor Única', category: 'Estrategia y Negocios', description: '' },
  9 => { title: 'Design Sprint en Proyectos de Transformación Digital', category: 'UX/UI y Diseño de Producto', description: '' },
  7 => { title: 'Masterclass: La Inteligencia Artificial en la rutina de los diseñadores', category: 'Innovación e IA', description: '' },
  14 => { title: 'Evaluación Psicológica en Manaus', category: 'Ciencias Humanas', description: '' },
  6 => { title: 'Copilot: Domina la IA en Microsoft 365', category: 'Innovación e IA', description: '' },
  12 => { title: 'Plan de Carrera', category: 'Gestión y Desarrollo', description: '' },
  11 => { title: 'Psicología Organizacional', category: 'Gestión y Comportamiento', description: '' },
  10 => { title: 'Bootcamp UX Design para todos', category: 'UX/UI y Diseño de Producto', description: '' }
}

Certification.all.each do |c|
  pt_title = c.title(locale: :'pt-BR') || c.title
  pt_category = c.category(locale: :'pt-BR') || c.category
  pt_description = c.description(locale: :'pt-BR') || c.description
  pt_issuer = c.issuer(locale: :'pt-BR') || c.issuer
  
  Mobility.with_locale(:'pt-BR') do
    c.title = pt_title
    c.category = pt_category
    c.description = pt_description
    c.issuer = pt_issuer
  end

  Mobility.with_locale(:'pt-PT') do
    c.title = pt_title
    c.category = pt_category
    c.description = pt_description
    c.issuer = pt_issuer
  end
  
  if trans = translations_en[c.id]
    Mobility.with_locale(:en) do
      c.title = trans[:title]
      c.category = trans[:category]
      c.description = trans[:description]
      c.issuer = pt_issuer
    end
  end
  
  if trans = translations_es[c.id]
    Mobility.with_locale(:es) do
      c.title = trans[:title]
      c.category = trans[:category]
      c.description = trans[:description]
      c.issuer = pt_issuer
    end
  end
  
  c.save!
end
