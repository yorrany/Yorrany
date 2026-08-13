import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview", "container"]

  connect() {
    // Show existing preview container if it has content
    if (this.previewTarget.innerHTML.trim() !== "") {
      this.containerTarget.classList.remove("hidden")
    }
  }

  preview() {
    const input = this.inputTarget
    const preview = this.previewTarget
    const container = this.containerTarget
    
    // Clear previous previews of newly uploaded files, keep existing ones if we wanted to
    // For simplicity, we just clear and re-render only the new ones + maybe we shouldn't wipe out the current ones 
    // Wait, if it's multiple, a new upload replaces the previous file selection.
    preview.innerHTML = ""

    if (input.files && input.files.length > 0) {
      container.classList.remove("hidden")
      
      Array.from(input.files).forEach(file => {
        if (!file.type.match('image.*')) return

        const reader = new FileReader()
        
        reader.onload = (e) => {
          const wrapper = document.createElement("div")
          wrapper.className = "relative group rounded-lg overflow-hidden border border-white/10"
          
          const img = document.createElement("img")
          img.src = e.target.result
          img.className = "w-full h-32 object-cover"
          
          wrapper.appendChild(img)
          preview.appendChild(wrapper)
        }
        
        reader.readAsDataURL(file)
      })
    } else {
      container.classList.add("hidden")
    }
  }
}
