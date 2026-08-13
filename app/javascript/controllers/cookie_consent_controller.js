import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (!localStorage.getItem("cookie_consent")) {
      this.element.classList.remove("hidden")
    }
  }

  acceptAll() {
    this.setConsent("all")
  }

  rejectAll() {
    this.setConsent("essential")
  }

  manage() {
    this.setConsent("essential")
    alert("Suas preferências foram salvas: Apenas Cookies Essenciais foram mantidos para proteger sua privacidade.")
  }

  setConsent(level) {
    localStorage.setItem("cookie_consent", level)
    this.element.classList.add("hidden")
  }
}
