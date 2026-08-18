namespace :portfolio do
  desc "Importa projetos do Behance para o banco de dados (CaseStudy), mesclando se já existirem"
  task import_behance: :environment do
    base_dir = Rails.root.join("Portfolio")
    json_path = base_dir.join("output", "projetos_consolidados.json")

    unless File.exist?(json_path)
      puts "Arquivo JSON de projetos não encontrado em: #{json_path}"
      exit 1
    end

    projects_data = JSON.parse(File.read(json_path))
    puts "Iniciando importação de #{projects_data.size} projetos..."

    I18n.locale = :'pt-BR'

    projects_data.each_with_index do |p_data, index|
      title = p_data["titulo"]&.strip
      next if title.blank?

      puts "\n[#{index + 1}/#{projects_data.size}] Processando: #{title}"

      # Localiza projeto existente pelo título no locale pt-BR ou por correspondência
      case_study = CaseStudy.all.find do |cs|
        cs.title&.strip&.downcase == title.downcase
      end || CaseStudy.new

      is_new = case_study.new_record?

      # Prepara atributos
      tags_str = Array(p_data["tags"]).join(", ")
      period_str = p_data["data_publicacao"]

      # Extrai descrição limpa se houver arquivo descricao.txt ou p_data['descricao']
      raw_desc = p_data["descricao"].to_s.strip
      if raw_desc.blank?
        [
          base_dir.join(title, "descricao.txt"),
          base_dir.join(title.tr(" ", "_"), "descricao.txt"),
          base_dir.join("output", title, "descricao.txt"),
          base_dir.join("output", title.tr(" ", "_"), "descricao.txt")
        ].each do |txt_path|
          if File.exist?(txt_path)
            lines = File.readlines(txt_path).map(&:strip).reject(&:blank?)
            clean_lines = []
            lines.each do |line|
              next if line =~ /navigate to|to view personalized|recruiter pro|all rights reserved|no use is allowed|do not sell|built for creatives|find inspiration|sell freelance|popular search terms|pinterest|facebook|título:|url:|---/i
              next if line =~ /appreciation|views for/i
              next if line == "Silves, Portugal" || line =~ /Attribution, Non-commercial/i
              clean_lines << line unless clean_lines.include?(line)
            end
            candidate = clean_lines.join("\n\n").strip
            if candidate.present? && candidate.length > raw_desc.length
              raw_desc = candidate
            end
          end
        end
      end

      # Atribuições / Mesclagem de informações (não sobrescreve se já tiver algo preenchido)
      case_study.title = title if case_study.title.blank?
      case_study.tags = tags_str if case_study.tags.blank? && tags_str.present?
      case_study.period = period_str if case_study.period.blank? && period_str.present?
      case_study.client = p_data["cliente"] if case_study.client.blank? && p_data["cliente"].present?
      case_study.tagline = p_data["slogan_tagline"] if case_study.tagline.blank? && p_data["slogan_tagline"].present?

      if case_study.summary.blank? && raw_desc.present?
        case_study.summary = raw_desc.truncate(300)
      end

      if case_study.full_description.blank? && raw_desc.present?
        case_study.full_description = raw_desc
      end

      # Identificar imagem de capa
      cover_candidates = [
        base_dir.join("output", p_data["caminho_local_capa"].to_s),
        base_dir.join(title, "capa.png"),
        base_dir.join(title, "capa.jpeg"),
        base_dir.join(title, "capa.jpg"),
        base_dir.join(title.tr(" ", "_"), "capa.png"),
        base_dir.join(title.tr(" ", "_"), "capa.jpeg"),
        base_dir.join(title.tr(" ", "_"), "capa.jpg"),
        base_dir.join("output", title, "capa.png"),
        base_dir.join("output", title, "capa.jpeg"),
        base_dir.join("output", title.tr(" ", "_"), "capa.png"),
        base_dir.join("output", title.tr(" ", "_"), "capa.jpeg")
      ]

      cover_path = cover_candidates.find { |path| path.present? && File.file?(path) }

      # Anexar capa se não possuir
      if !case_study.image.attached? && cover_path.present?
        puts "  -> Anexando capa: #{File.basename(cover_path)}"
        case_study.image.attach(
          io: File.open(cover_path),
          filename: File.basename(cover_path)
        )
      end

      case_study.skip_auto_translate = true
      case_study.save!

      # Identificar e anexar imagens da galeria
      existing_gallery_filenames = case_study.gallery_images.map { |img| img.filename.to_s }
      gallery_files = Set.new

      # 1. Do JSON
      Array(p_data["caminhos_locais_galeria"]).each do |rel|
        fpath = base_dir.join("output", rel)
        gallery_files.add(fpath.to_s) if File.file?(fpath)
      end

      # 2. Das pastas locais
      [
        base_dir.join(title),
        base_dir.join(title.tr(" ", "_")),
        base_dir.join("output", title),
        base_dir.join("output", title.tr(" ", "_")),
        base_dir.join("output", title, "imagens"),
        base_dir.join("output", title.tr(" ", "_"), "imagens")
      ].each do |folder|
        next unless File.directory?(folder)
        Dir.glob(folder.join("*.{png,jpg,jpeg,gif,webp,PNG,JPG,JPEG}").to_s).each do |img_file|
          fname = File.basename(img_file)
          next if fname.start_with?("capa")
          gallery_files.add(img_file)
        end
      end

      # Ordena arquivos por nome
      sorted_gallery = gallery_files.to_a.sort_by do |path|
        basename = File.basename(path, ".*")
        num = basename.scan(/\d+/).first.to_i
        [ num > 0 ? num : 9999, basename ]
      end

      new_images_count = 0
      sorted_gallery.each do |img_path|
        fname = File.basename(img_path)
        next if existing_gallery_filenames.include?(fname)

        case_study.gallery_images.attach(
          io: File.open(img_path),
          filename: fname
        )
        existing_gallery_filenames << fname
        new_images_count += 1
      end

      status_label = is_new ? "Criado" : "Mesclado/Atualizado"
      puts "  -> Status: #{status_label} | Capa anexada: #{case_study.image.attached?} | Imagens na galeria: #{case_study.gallery_images.count} (+#{new_images_count} novas)"
    end

    puts "\nImportação e mesclagem concluídas com sucesso! Total no banco: #{CaseStudy.count}"
  end
end
