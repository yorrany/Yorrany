import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  connect() {
    this.toggleVisibility = this.toggleVisibility.bind(this)
    window.addEventListener("scroll", this.toggleVisibility)
    this.toggleVisibility()
  }

  disconnect() {
    window.removeEventListener("scroll", this.toggleVisibility)
  }

  toggleVisibility() {
    if (window.scrollY > 300) {
      this.buttonTarget.classList.remove("opacity-0", "translate-y-4", "pointer-events-none")
      this.buttonTarget.classList.add("opacity-100", "translate-y-0", "pointer-events-auto")
    } else {
      this.buttonTarget.classList.add("opacity-0", "translate-y-4", "pointer-events-none")
      this.buttonTarget.classList.remove("opacity-100", "translate-y-0", "pointer-events-auto")
    }
  }

  scrollToTop(event) {
    event.preventDefault()
    window.scrollTo({
      top: 0,
      behavior: "smooth"
    })
  }
}
