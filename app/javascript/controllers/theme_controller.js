import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["iconLight", "iconDark"]

  connect() {
    this.theme = localStorage.getItem("theme") || "auto"
    this.applyTheme()
  }

  toggle(e) {
    if (e) e.preventDefault()
    const isDark = document.documentElement.classList.contains("dark")
    this.theme = isDark ? "light" : "dark"
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
    const isDark = document.documentElement.classList.contains("dark")
    
    // If current mode is dark, show the Light icon (to switch to light mode)
    if (isDark) {
      if (this.hasIconLightTarget) {
        this.iconLightTarget.classList.remove("hidden")
      }
      if (this.hasIconDarkTarget) {
        this.iconDarkTarget.classList.add("hidden")
      }
    } else {
      // If current mode is light, show the Dark icon (to switch to dark mode)
      if (this.hasIconLightTarget) {
        this.iconLightTarget.classList.add("hidden")
      }
      if (this.hasIconDarkTarget) {
        this.iconDarkTarget.classList.remove("hidden")
      }
    }
  }
}
