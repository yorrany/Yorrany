import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel", "indicator"]
  static values = { activeIndex: { type: Number, default: 0 } }

  connect() {
    this.showActiveTab()
    this.startAutoRotate()
  }

  disconnect() {
    this.stopAutoRotate()
  }

  switch(event) {
    this.stopAutoRotate()
    const index = parseInt(event.currentTarget.dataset.index, 10)
    if (!isNaN(index)) {
      this.activeIndexValue = index
      this.showActiveTab()
    }
  }

  next() {
    this.activeIndexValue = (this.activeIndexValue + 1) % this.panelTargets.length
    this.showActiveTab()
  }

  prev() {
    this.activeIndexValue = (this.activeIndexValue - 1 + this.panelTargets.length) % this.panelTargets.length
    this.showActiveTab()
  }

  startAutoRotate() {
    this.timer = setInterval(() => {
      this.next()
    }, 8000)
  }

  stopAutoRotate() {
    if (this.timer) {
      clearInterval(this.timer)
      this.timer = null
    }
  }

  showActiveTab() {
    const current = this.activeIndexValue

    this.tabTargets.forEach((tab, index) => {
      const isActive = index === current
      if (isActive) {
        tab.classList.remove("text-neutral-500", "dark:text-neutral-400", "border-transparent")
        tab.classList.add("text-[#003CA5]", "dark:text-[#5B8EFF]", "border-[#003CA5]", "dark:border-[#5B8EFF]", "bg-[#003CA5]/10", "font-bold")
      } else {
        tab.classList.remove("text-[#003CA5]", "dark:text-[#5B8EFF]", "border-[#003CA5]", "dark:border-[#5B8EFF]", "bg-[#003CA5]/10", "font-bold")
        tab.classList.add("text-neutral-500", "dark:text-neutral-400", "border-transparent")
      }
    })

    this.panelTargets.forEach((panel, index) => {
      const isActive = index === current
      if (isActive) {
        panel.classList.remove("hidden", "opacity-0", "scale-95")
        panel.classList.add("block", "opacity-100", "scale-100")
      } else {
        panel.classList.add("hidden", "opacity-0", "scale-95")
        panel.classList.remove("block", "opacity-100", "scale-100")
      }
    })
  }
}
