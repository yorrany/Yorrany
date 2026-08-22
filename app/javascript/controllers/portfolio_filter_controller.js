import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "item"]

  filter(event) {
    const selectedFilter = event.currentTarget.dataset.filter
    
    // Atualizar estado visual dos botões de filtro
    this.buttonTargets.forEach(btn => {
      if (btn.dataset.filter === selectedFilter) {
        btn.classList.add("bg-[#003CA5]", "text-white", "border-[#003CA5]", "font-bold", "shadow-md")
        btn.classList.remove("bg-brand-surface", "dark:bg-[#13171F]", "text-brand-tinta/70", "dark:text-neutral-300", "border-brand-tinta/10", "dark:border-white/10")
      } else {
        btn.classList.remove("bg-[#003CA5]", "text-white", "border-[#003CA5]", "font-bold", "shadow-md")
        btn.classList.add("bg-brand-surface", "dark:bg-[#13171F]", "text-brand-tinta/70", "dark:text-neutral-300", "border-brand-tinta/10", "dark:border-white/10")
      }
    })

    const isAll = ["Todos", "All", "todos", "all"].includes(selectedFilter.toLowerCase())

    // Filtrar itens com animação suave
    this.itemTargets.forEach(item => {
      const tags = (item.dataset.tags || "").toLowerCase()
      const matches = isAll || tags.includes(selectedFilter.toLowerCase())

      if (matches) {
        item.style.display = ""
        requestAnimationFrame(() => {
          item.style.opacity = "1"
          item.style.transform = "scale(1)"
        })
      } else {
        item.style.opacity = "0"
        item.style.transform = "scale(0.96)"
        setTimeout(() => {
          if (!matches) {
            item.style.display = "none"
          }
        }, 200)
      }
    })
  }
}
