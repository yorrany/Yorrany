import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.handleScroll = this.handleScroll.bind(this)
    window.addEventListener("scroll", this.handleScroll)
    this.handleScroll() // Initialize state
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll)
  }

  handleScroll() {
    if (window.scrollY > 10) {
      this.element.classList.add("shadow-md", "dark:shadow-brand-dark-primaria/5")
      this.element.classList.replace("border-brand-tinta/5", "border-brand-tinta/10")
      this.element.classList.replace("dark:border-white/5", "dark:border-white/10")
    } else {
      this.element.classList.remove("shadow-md", "dark:shadow-brand-dark-primaria/5")
      this.element.classList.replace("border-brand-tinta/10", "border-brand-tinta/5")
      this.element.classList.replace("dark:border-white/10", "dark:border-white/5")
    }
  }
}
