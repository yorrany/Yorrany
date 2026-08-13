import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { sitekey: String }

  connect() {
    this.renderTurnstile()
  }

  disconnect() {
    if (this.widgetId !== undefined && window.turnstile) {
      window.turnstile.remove(this.widgetId)
      this.widgetId = undefined
    }
  }

  renderTurnstile() {
    if (window.turnstile) {
      this.widgetId = window.turnstile.render(this.element, {
        sitekey: this.sitekeyValue,
        theme: 'dark'
      })
    } else {
      // If the Turnstile script hasn't loaded yet, it will call window.onloadTurnstileCallback
      window.onloadTurnstileCallback = () => {
        this.widgetId = window.turnstile.render(this.element, {
          sitekey: this.sitekeyValue,
          theme: 'dark'
        })
      }
    }
  }
}
