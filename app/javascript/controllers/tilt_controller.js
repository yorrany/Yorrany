import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    max: { type: Number, default: 8 },
    perspective: { type: Number, default: 1000 },
    scale: { type: Number, default: 1.02 }
  }

  connect() {
    this.isTouch = "ontouchstart" in window || navigator.maxTouchPoints > 0
    if (this.isTouch) return

    this.element.style.transformStyle = "preserve-3d"
    this.element.style.transition = "transform 0.15s ease-out, box-shadow 0.3s ease"
    this.element.addEventListener("mousemove", this.onMouseMove.bind(this))
    this.element.addEventListener("mouseleave", this.onMouseLeave.bind(this))
  }

  disconnect() {
    if (this.isTouch) return
    this.element.removeEventListener("mousemove", this.onMouseMove.bind(this))
    this.element.removeEventListener("mouseleave", this.onMouseLeave.bind(this))
  }

  onMouseMove(e) {
    const rect = this.element.getBoundingClientRect()
    const x = e.clientX - rect.left
    const y = e.clientY - rect.top
    const centerX = rect.width / 2
    const centerY = rect.height / 2

    const rotateX = ((y - centerY) / centerY) * -this.maxValue
    const rotateY = ((x - centerX) / centerX) * this.maxValue

    this.element.style.transform = `perspective(${this.perspectiveValue}px) rotateX(${rotateX.toFixed(2)}deg) rotateY(${rotateY.toFixed(2)}deg) scale3d(${this.scaleValue}, ${this.scaleValue}, ${this.scaleValue})`
  }

  onMouseLeave() {
    this.element.style.transition = "transform 0.5s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.5s ease"
    this.element.style.transform = `perspective(${this.perspectiveValue}px) rotateX(0deg) rotateY(0deg) scale3d(1, 1, 1)`
  }
}
