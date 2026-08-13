class ContactController < ApplicationController
  def vcard
    vcard_content = [
      "BEGIN:VCARD",
      "VERSION:3.0",
      "N:Braga;Yorrany;;;",
      "FN:Yorrany Braga",
      "ORG:Yorrany Braga",
      "TITLE:Principal Product Designer",
      "EMAIL;type=INTERNET;type=WORK:yorranymb@gmail.com",
      "URL:https://yorrany.com.br",
      "END:VCARD"
    ].join("\r\n")

    send_data vcard_content, filename: "yorrany_braga.vcf", type: "text/vcard", disposition: "attachment"
  end
end
