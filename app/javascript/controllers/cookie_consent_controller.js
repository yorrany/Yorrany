import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["backdrop", "modal", "minimized"]

  connect() {
    if (!localStorage.getItem("cookie_consent")) {
      this.showModal()
    } else {
      this.showMinimized()
    }
  }

  showModal() {
    this.backdropTarget.classList.remove("hidden")
    // Delay pequeno para permitir transição de opacidade do Tailwind
    setTimeout(() => {
      this.backdropTarget.classList.remove("opacity-0")
      this.backdropTarget.classList.add("opacity-100")
      this.modalTarget.classList.remove("scale-95")
      this.modalTarget.classList.add("scale-100")
    }, 10)
    
    this.minimizedTarget.classList.add("hidden")
    this.minimizedTarget.classList.remove("opacity-100")
    
    // Bloquear scroll
    document.body.classList.add("overflow-hidden")
  }

  hideModal() {
    this.backdropTarget.classList.remove("opacity-100")
    this.backdropTarget.classList.add("opacity-0")
    this.modalTarget.classList.remove("scale-100")
    this.modalTarget.classList.add("scale-95")
    
    setTimeout(() => {
      this.backdropTarget.classList.add("hidden")
      this.showMinimized()
    }, 300)
    
    // Liberar scroll
    document.body.classList.remove("overflow-hidden")
  }

  showMinimized() {
    this.minimizedTarget.classList.remove("hidden")
    setTimeout(() => {
      this.minimizedTarget.classList.add("opacity-100")
    }, 10)
  }

  acceptAll() {
    this.setConsent("all")
  }

  rejectAll() {
    this.setConsent("essential")
  }

  revoke() {
    localStorage.removeItem("cookie_consent")
    this.showModal()
  }

  setConsent(level) {
    localStorage.setItem("cookie_consent", level)
    this.hideModal()
  }
}
