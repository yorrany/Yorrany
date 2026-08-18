class ContactController < ApplicationController
  protect_from_forgery with: :null_session, only: [ :create ]

  def vcard
    photo_path = Rails.root.join("app", "assets", "images", "yorrany_thumb.jpg")
    photo_base64 = File.exist?(photo_path) ? Base64.strict_encode64(File.read(photo_path)) : ""

    vcard_lines = [
      "BEGIN:VCARD",
      "VERSION:3.0",
      "N:Braga;Yorrany;;;",
      "FN:Yorrany Braga",
      "ORG:Yorrany Braga",
      "TITLE:Principal Product Designer",
      "EMAIL;TYPE=INTERNET,WORK:yorranymb@gmail.com",
      "TEL;TYPE=CELL,VOICE:+55 92 98414-3818",
      "URL:https://yorrany.com.br",
      "URL;type=LinkedIn:https://www.linkedin.com/in/yorrany",
      "URL;type=Behance:https://www.behance.net/yorrany",
      "URL;type=GitHub:https://github.com/yorrany",
      "NOTE:Design estratégico e insights comportamentais que impulsionam resultados de negócios.\\nPortfólio online: yorrany.com.br",
      "ADR;TYPE=WORK:;;;Manaus;AM;Brasil;"
    ]

    if photo_base64.present?
      vcard_lines << "PHOTO;ENCODING=b;TYPE=JPEG:#{photo_base64}"
    end

    vcard_lines += [
      "REV:#{Time.current.utc.strftime('%Y%m%dT%H%M%SZ')}",
      "UID:urn:uuid:#{SecureRandom.uuid}",
      "END:VCARD"
    ]

    vcard_content = vcard_lines.join("\r\n") + "\r\n"

    send_data vcard_content, filename: "yorrany_braga.vcf", type: "text/vcard", disposition: "attachment"
  end

  def create
    # Anti-spam: honeypot field
    honeypot = (params[:nickname] || params[:website] || params.dig(:contact, :nickname)).to_s.strip
    if honeypot.present?
      render json: { success: true, message: "Mensagem enviada com sucesso!" }
      return
    end

    name = (params[:name] || params.dig(:contact, :name)).to_s.strip
    email = (params[:email] || params.dig(:contact, :email)).to_s.strip
    message = (params[:message] || params.dig(:contact, :message)).to_s.strip

    if name.blank? || email.blank? || message.blank?
      render json: { success: false, error: "Por favor, preencha todos os campos." }, status: :unprocessable_entity
      return
    end

    unless email =~ URI::MailTo::EMAIL_REGEXP
      render json: { success: false, error: "Por favor, informe um endereço de e-mail válido." }, status: :unprocessable_entity
      return
    end

    recipient = ENV.fetch("CONTACT_RECIPIENT_EMAIL", "falecom@yorrany.com.br")
    from_email = ENV.fetch("RESEND_FROM_EMAIL", "onboarding@resend.dev")

    html_content = <<~HTML
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <style>
            body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; line-height: 1.6; color: #1a1e28; background-color: #f7f8fc; margin: 0; padding: 24px; }
            .card { max-width: 580px; margin: 0 auto; background: #ffffff; border-radius: 16px; padding: 32px; border: 1px solid #e2e8f0; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05); }
            .header { border-bottom: 2px solid #003CA5; padding-bottom: 16px; margin-bottom: 24px; }
            .title { color: #003CA5; margin: 0; font-size: 20px; font-weight: 700; }
            .subtitle { color: #64748b; margin: 4px 0 0 0; font-size: 13px; }
            .field { margin-bottom: 20px; }
            .label { color: #475569; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 4px; }
            .value { font-size: 15px; color: #0f172a; font-weight: 500; }
            .message-box { background-color: #f8fafc; border-radius: 12px; padding: 18px; border: 1px solid #e2e8f0; font-size: 14px; white-space: pre-wrap; color: #334155; line-height: 1.7; }
            .footer { text-align: center; margin-top: 28px; padding-top: 20px; border-top: 1px solid #f1f5f9; }
            .btn { display: inline-block; background-color: #003CA5; color: #ffffff !important; text-decoration: none; padding: 12px 28px; border-radius: 9999px; font-weight: 600; font-size: 14px; }
          </style>
        </head>
        <body>
          <div class="card">
            <div class="header">
              <h2 class="title">Nova Mensagem de Contato</h2>
              <p class="subtitle">Recebida através de yorrany.com.br</p>
            </div>
            <div class="field">
              <div class="label">Remetente</div>
              <div class="value">#{ERB::Util.html_escape(name)}</div>
            </div>
            <div class="field">
              <div class="label">E-mail</div>
              <div class="value"><a href="mailto:#{ERB::Util.html_escape(email)}" style="color: #003CA5; text-decoration: none;">#{ERB::Util.html_escape(email)}</a></div>
            </div>
            <div class="field">
              <div class="label">Mensagem</div>
              <div class="message-box">#{ERB::Util.html_escape(message)}</div>
            </div>
            <div class="footer">
              <a href="mailto:#{ERB::Util.html_escape(email)}?subject=Re:%20Contato%20via%20Portf%C3%B3lio" class="btn">Responder #{ERB::Util.html_escape(name.split.first)}</a>
            </div>
          </div>
        </body>
      </html>
    HTML

    text_content = <<~TEXT
      Nova Mensagem de Contato (yorrany.com.br)
      =========================================
      Remetente: #{name}
      E-mail: #{email}

      Mensagem:
      #{message}
    TEXT

    begin
      Resend.api_key = ENV["RESEND_API_KEY"] || Rails.application.credentials.dig(:resend, :api_key)

      Resend::Emails.send({
        from: from_email,
        to: recipient,
        reply_to: email,
        subject: "📩 Nova Mensagem: #{name} (yorrany.com.br)",
        html: html_content,
        text: text_content
      })

      render json: { success: true, message: "Mensagem transmitida com sucesso!" }
    rescue => e
      Rails.logger.error "[ContactController] Falha ao enviar email via Resend: #{e.class} - #{e.message}"
      render json: { success: false, error: "Ocorreu um erro ao enviar sua mensagem. Por favor, tente novamente ou envie direto para #{recipient}." }, status: :internal_server_error
    end
  end
end
