import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]
  static values = {
    threshold: { type: Number, default: 0.12 },
    delay: { type: Number, default: 70 }
  }

  connect() {
    this.observer = new IntersectionObserver(this.handleIntersect.bind(this), {
      root: null,
      threshold: this.thresholdValue,
      rootMargin: "0px 0px -40px 0px"
    })

    const elements = this.hasItemTarget ? this.itemTargets : [this.element]
    elements.forEach((el, index) => {
      el.classList.add("reveal-init")
      el.style.transitionDelay = `${(index % 5) * this.delayValue}ms`
      this.observer.observe(el)
    })
  }

  disconnect() {
    if (this.observer) {
      this.observer.disconnect()
    }
  }

  handleIntersect(entries) {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add("reveal-visible")
        this.observer.unobserve(entry.target)
      }
    })
  }
}
