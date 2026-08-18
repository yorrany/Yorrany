import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "toggleText"]

  connect() {
    this.expanded = false
    this.checkMobile()
    
    this.resizeHandler = this.checkMobile.bind(this)
    window.addEventListener('resize', this.resizeHandler)
  }
  
  disconnect() {
    window.removeEventListener('resize', this.resizeHandler)
  }

  checkMobile() {
    if (window.innerWidth < 640 && !this.expanded) {
      this.collapse()
    } else {
      this.resetDesktop()
    }
  }

  expand(e) {
    if (e) e.preventDefault()
    this.expanded = !this.expanded
    
    if (this.expanded) {
      this.contentTarget.style.maxHeight = this.contentTarget.scrollHeight + "px"
      if (this.hasToggleTextTarget) {
        this.toggleTextTarget.innerText = "Ver menos ▴"
      }
    } else {
      this.collapse()
    }
  }
  
  collapse() {
    this.contentTarget.style.maxHeight = "0px"
    if (this.hasToggleTextTarget) {
      this.toggleTextTarget.innerText = "Ver mais ▾"
    }
  }
  
  resetDesktop() {
    if (window.innerWidth >= 640) {
      this.contentTarget.style.maxHeight = ""
    }
  }
}
