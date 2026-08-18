import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mainImage", "thumb"]

  switch(event) {
    event.stopPropagation()
    const targetUrl = event.currentTarget.dataset.imageUrl
    if (!targetUrl || !this.hasMainImageTarget) return

    this.mainImageTarget.src = targetUrl

    if (this.hasThumbTarget) {
      this.thumbTargets.forEach(t => {
        if (t === event.currentTarget) {
          t.classList.add("ring-2", "ring-[#003CA5]", "scale-110", "opacity-100")
          t.classList.remove("opacity-50")
        } else {
          t.classList.remove("ring-2", "ring-[#003CA5]", "scale-110", "opacity-100")
          t.classList.add("opacity-50")
        }
      })
    }
  }
}
