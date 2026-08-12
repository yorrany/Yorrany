import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.theme = localStorage.getItem("theme") || "auto"
    this.applyTheme()
  }

  setLight(e) {
    if (e) e.preventDefault()
    this.theme = "light"
    this.applyTheme()
  }

  setDark(e) {
    if (e) e.preventDefault()
    this.theme = "dark"
    this.applyTheme()
  }

  setAuto(e) {
    if (e) e.preventDefault()
    this.theme = "auto"
    this.applyTheme()
  }

  applyTheme() {
    if (this.theme === "auto") {
      localStorage.removeItem("theme")
    } else {
      localStorage.setItem("theme", this.theme)
    }
    this.updateHtmlClass()
    this.updateActiveButton()
  }

  updateHtmlClass() {
    if (this.theme === "dark" || (this.theme === "auto" && window.matchMedia("(prefers-color-scheme: dark)").matches)) {
      document.documentElement.classList.add("dark")
    } else {
      document.documentElement.classList.remove("dark")
    }
  }

  updateActiveButton() {
    const buttons = this.element.querySelectorAll("button[data-action^='click->theme#set']")
    const inactiveClasses = ["text-brand-tinta/60", "dark:text-brand-dark-tinta/60", "hover:text-brand-tinta", "dark:hover:text-brand-dark-tinta"]
    const activeClasses = ["bg-brand-tinta", "dark:bg-brand-dark-tinta", "text-brand-surface", "dark:text-brand-dark-fundo"]

    buttons.forEach(btn => {
      btn.classList.remove(...activeClasses)
      btn.classList.add(...inactiveClasses)
      
      const action = btn.getAttribute("data-action")
      if (
        (this.theme === "light" && action.includes("setLight")) ||
        (this.theme === "dark" && action.includes("setDark")) ||
        (this.theme === "auto" && action.includes("setAuto"))
      ) {
        btn.classList.remove(...inactiveClasses)
        btn.classList.add(...activeClasses)
      }
    })
  }
}
