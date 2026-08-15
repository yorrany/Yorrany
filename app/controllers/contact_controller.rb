class ContactController < ApplicationController
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
end
