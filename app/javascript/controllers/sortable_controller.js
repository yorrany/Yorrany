import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import { FetchRequest } from "@rails/request.js"

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      handle: "[data-sortable-handle]",
      onEnd: this.end.bind(this)
    })
  }

  async end(event) {
    if (!this.hasUrlValue) return
    
    let ids = Array.from(this.element.children).map(el => el.dataset.sortableId).filter(id => id != null)

    const request = new FetchRequest("patch", this.urlValue, {
      body: JSON.stringify({ ordered_ids: ids }),
      responseKind: "json"
    })
    
    await request.perform()
  }
}
