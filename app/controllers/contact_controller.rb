class ContactController < ApplicationController
  def vcard
    vcard_content = [
      "BEGIN:VCARD",
      "VERSION:3.0",
      "N:Braga;Yorrany;;;",
      "FN:Yorrany Braga",
      "ORG:Yorrany Braga",
      "TITLE:Principal Product Designer",
      "EMAIL;TYPE=INTERNET,WORK:yorranymb@gmail.com",
      "URL:https://yorrany.com.br",
      "REV:#{Time.current.utc.strftime('%Y%m%dT%H%M%SZ')}",
      "UID:urn:uuid:#{SecureRandom.uuid}",
      "END:VCARD"
    ].join("\r\n")

    send_data vcard_content, filename: "yorrany_braga.vcf", type: "text/vcard", disposition: "attachment"
  end
end
