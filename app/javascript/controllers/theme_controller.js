import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["iconLight", "iconDark"]

  connect() {
    this.boundSync = this.syncState.bind(this)
    this.boundMediaChange = this.handleMediaChange.bind(this)
    this.mediaQuery = window.matchMedia("(prefers-color-scheme: dark)")

    window.addEventListener("theme-changed", this.boundSync)
    window.addEventListener("storage", this.boundSync)
    this.mediaQuery.addEventListener("change", this.boundMediaChange)

    this.applyTheme(false)
  }

  disconnect() {
    window.removeEventListener("theme-changed", this.boundSync)
    window.removeEventListener("storage", this.boundSync)
    if (this.mediaQuery && this.boundMediaChange) {
      this.mediaQuery.removeEventListener("change", this.boundMediaChange)
    }
  }

  handleMediaChange() {
    const savedTheme = localStorage.getItem("theme")
    if (!savedTheme || savedTheme === "auto" || savedTheme === "system") {
      this.applyTheme(true)
    }
  }

  toggle(e) {
    if (e) e.preventDefault()
    const isDark = document.documentElement.classList.contains("dark")
    const newTheme = isDark ? "light" : "dark"
    localStorage.setItem("theme", newTheme)
    this.applyTheme(true)
  }

  applyTheme(dispatch = true) {
    const savedTheme = localStorage.getItem("theme")
    const isDark = savedTheme === "dark" || ((!savedTheme || savedTheme === "auto" || savedTheme === "system") && window.matchMedia("(prefers-color-scheme: dark)").matches)
    
    if (isDark) {
      document.documentElement.classList.add("dark")
    } else {
      document.documentElement.classList.remove("dark")
    }

    if (dispatch) {
      window.dispatchEvent(new CustomEvent("theme-changed"))
    } else {
      this.syncState()
    }
  }

  syncState() {
    const isDark = document.documentElement.classList.contains("dark")
    
    // Se o tema atual é dark, exibe o ícone de Sol (iconLight) para alternar para light
    if (this.hasIconLightTarget) {
      this.iconLightTarget.classList.toggle("hidden", !isDark)
    }
    // Se o tema atual é light, exibe o ícone de Lua (iconDark) para alternar para dark
    if (this.hasIconDarkTarget) {
      this.iconDarkTarget.classList.toggle("hidden", isDark)
    }
  }
}
