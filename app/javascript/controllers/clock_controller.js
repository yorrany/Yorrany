import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.updateClock()
    this.timer = setInterval(() => this.updateClock(), 1000)
  }

  disconnect() {
    if (this.timer) {
      clearInterval(this.timer)
    }
  }

  updateClock() {
    const now = new Date()
    const lisbonTime = now.toLocaleTimeString("en-GB", { timeZone: "Europe/Lisbon", hour: "2-digit", minute: "2-digit", second: "2-digit" })
    const madridTime = now.toLocaleTimeString("en-GB", { timeZone: "Europe/Madrid", hour: "2-digit", minute: "2-digit", second: "2-digit" })
    
    this.element.textContent = `${lisbonTime} (LIS) · ${madridTime} (MAD)`
  }
}
