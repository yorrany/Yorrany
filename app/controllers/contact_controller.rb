class ContactController < ApplicationController
  def vcard
    vcard_content = <<~VCARD
      BEGIN:VCARD
      VERSION:3.0
      FN:Yorrany Braga
      TITLE:Principal Product Designer
      EMAIL:yorranymb@gmail.com
      URL:https://yorrany.com.br
      END:VCARD
    VCARD
    send_data vcard_content, filename: "yorrany_braga.vcf", type: "text/vcard", disposition: "attachment"
  end
end
