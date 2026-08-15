import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["drawer", "backdrop", "hamburger", "closeBtn"]

  connect() {
    this.isOpen = false
  }

  toggle() {
    this.isOpen ? this.close() : this.open()
  }

  open() {
    this.isOpen = true
    document.body.classList.add("overflow-hidden")
    this.backdropTarget.classList.remove("hidden")
    requestAnimationFrame(() => {
      this.backdropTarget.classList.remove("opacity-0")
      this.drawerTarget.classList.remove("translate-x-full")
    })
  }

  close() {
    this.isOpen = false
    this.backdropTarget.classList.add("opacity-0")
    this.drawerTarget.classList.add("translate-x-full")
    setTimeout(() => {
      this.backdropTarget.classList.add("hidden")
      document.body.classList.remove("overflow-hidden")
    }, 300)
  }

  // Close on link click (smooth scroll navigation)
  navigate(event) {
    this.close()
  }
}
