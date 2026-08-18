require "base64"

class CvController < ApplicationController
  def show
    locale_param = params[:filename].to_s.split("_").last.to_s.gsub(".pdf", "")

    case locale_param
    when "pt", "pt-PT", "pt-BR"
      I18n.locale = :'pt-PT'
    when "es"
      I18n.locale = :es
    else
      I18n.locale = :en
    end

    @experiences = ExperienceItem.order(created_at: :desc)
    @certifications = Certification.all
    @academic_bgs = AcademicBackground.order(created_at: :desc)

    html = render_to_string({
      template: "cv/show",
      layout: "cv",
      formats: [ :html ]
    })

    page_label = if locale_param.start_with?("es")
                   "Pág."
    elsif locale_param.start_with?("pt")
                   "Pág."
    else
                   "Page"
    end

    europass_label = if locale_param.start_with?("es")
                       "Formato Oficial Europass"
    elsif locale_param.start_with?("pt")
                       "Formato Oficial Europass"
    else
                       "Official Europass Format"
    end

    logo_base64 = Base64.strict_encode64(File.read(Rails.root.join("app/assets/images/yorrany-horizontal.svg")))
    footer_html = %Q(<div style="font-size: 9px; text-align: center; width: 100%; margin: 0 auto; color: #888; font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace; display: flex; justify-content: center; align-items: center; gap: 8px;"><img src="data:image/svg+xml;base64,#{logo_base64}" style="height: 12px; width: auto; opacity: 0.7;" /> <span>yorrany.com.br</span><span style="border-left: 1px solid #ccc; padding-left: 8px;">#{europass_label}</span><span style="border-left: 1px solid #ccc; padding-left: 8px;">#{page_label} <span class="pageNumber"></span> / <span class="totalPages"></span></span></div>)

    grover = Grover.new(html,
      format: "A4",
      margin: { top: "12mm", bottom: "10mm", left: "14mm", right: "14mm" },
      print_background: true,
      display_header_footer: true,
      header_template: "<div></div>",
      footer_template: footer_html,
      display_url: request.base_url,
      launch_args: [ "--no-sandbox", "--disable-setuid-sandbox" ]
    )

    pdf = grover.to_pdf

    send_data pdf, filename: "#{params[:filename].to_s.gsub('.pdf', '')}.pdf", type: "application/pdf", disposition: "inline"
  end
end
