import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["iconLight", "iconDark"]

  connect() {
    this.boundSync = this.syncState.bind(this)
    this.boundMediaChange = this.handleMediaChange.bind(this)

    // Listener universal para mudanças de tema do sistema (iOS / Android / Desktop)
    if (window.matchMedia) {
      this.mediaQuery = window.matchMedia("(prefers-color-scheme: dark)")
      if (this.mediaQuery.addEventListener) {
        this.mediaQuery.addEventListener("change", this.boundMediaChange)
      } else if (this.mediaQuery.addListener) {
        this.mediaQuery.addListener(this.boundMediaChange)
      }
    }

    window.addEventListener("theme-changed", this.boundSync)
    window.addEventListener("storage", this.boundSync)
    document.addEventListener("turbo:load", this.boundSync)

    // Aplica o tema correto ao conectar
    this.applyTheme(false)
  }

  disconnect() {
    window.removeEventListener("theme-changed", this.boundSync)
    window.removeEventListener("storage", this.boundSync)
    document.removeEventListener("turbo:load", this.boundSync)

    if (this.mediaQuery && this.boundMediaChange) {
      if (this.mediaQuery.removeEventListener) {
        this.mediaQuery.removeEventListener("change", this.boundMediaChange)
      } else if (this.mediaQuery.removeListener) {
        this.mediaQuery.removeListener(this.boundMediaChange)
      }
    }
  }

  handleMediaChange() {
    const savedTheme = localStorage.getItem("theme")
    // Se o usuário não travou manualmente o tema em 'dark' ou 'light', atualiza de acordo com o dispositivo
    if (!savedTheme || savedTheme === "auto" || savedTheme === "system") {
      this.applyTheme(true)
    }
  }

  toggle(e) {
    if (e) e.preventDefault()
    const isCurrentlyDark = document.documentElement.classList.contains("dark")
    const newTheme = isCurrentlyDark ? "light" : "dark"
    
    try {
      localStorage.setItem("theme", newTheme)
    } catch (err) {
      console.warn("Could not save theme preference to localStorage:", err)
    }

    this.applyTheme(true)
  }

  applyTheme(dispatch = true) {
    let isDark = false
    try {
      const savedTheme = localStorage.getItem("theme")
      const systemPrefersDark = window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches

      if (savedTheme === "dark") {
        isDark = true
      } else if (savedTheme === "light") {
        isDark = false
      } else {
        // Detecção automática nativa do dispositivo (modo padrão)
        isDark = systemPrefersDark
      }
    } catch (err) {
      isDark = window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches
    }
    
    if (isDark) {
      document.documentElement.classList.add("dark")
      document.documentElement.style.colorScheme = "dark"
    } else {
      document.documentElement.classList.remove("dark")
      document.documentElement.style.colorScheme = "light"
    }

    // Atualiza meta theme-color para navegadores mobile (barra de status e topo)
    const themeColorMeta = document.getElementById("theme-color-meta") || document.querySelector('meta[name="theme-color"]')
    if (themeColorMeta) {
      themeColorMeta.setAttribute("content", isDark ? "#0A0E19" : "#F7F8FC")
    }

    if (dispatch) {
      window.dispatchEvent(new CustomEvent("theme-changed"))
    } else {
      this.syncState()
    }
  }

  syncState() {
    const isDark = document.documentElement.classList.contains("dark")
    
    // Se o tema atual é dark, exibe o ícone de Sol (iconLight) para permitir alternar para light
    if (this.hasIconLightTarget) {
      this.iconLightTarget.classList.toggle("hidden", !isDark)
    }
    // Se o tema atual é light, exibe o ícone de Lua (iconDark) para permitir alternar para dark
    if (this.hasIconDarkTarget) {
      this.iconDarkTarget.classList.toggle("hidden", isDark)
    }
  }
}
