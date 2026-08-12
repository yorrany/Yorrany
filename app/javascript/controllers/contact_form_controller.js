import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["copyButton", "copyIcon", "checkIcon", "copyText", "form", "successMessage", "nameInput", "emailInput"]

  connect() {
  }

  disconnect() {
  }

  copyEmail(event) {
    event.preventDefault()
    const email = "falecom@yorrany.com.br"
    navigator.clipboard.writeText(email).then(() => {
      this.copyIconTarget.classList.add("hidden")
      this.checkIconTarget.classList.remove("hidden")
      const oldText = this.copyTextTarget.innerText
      this.copyTextTarget.innerText = "Copiado!"
      
      setTimeout(() => {
        this.copyIconTarget.classList.remove("hidden")
        this.checkIconTarget.classList.add("hidden")
        this.copyTextTarget.innerText = "Copiar"
      }, 2500)
    })
  }

  submit(event) {
    event.preventDefault()
    this.formTarget.classList.add("hidden")
    this.successMessageTarget.classList.remove("hidden")

    setTimeout(() => {
      this.successMessageTarget.classList.add("hidden")
      this.formTarget.classList.remove("hidden")
      this.formTarget.reset()
    }, 5000)
  }
}
