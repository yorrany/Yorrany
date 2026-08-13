import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "item"]

  filter(event) {
    const selectedFilter = event.currentTarget.dataset.filter
    
    // Atualizar botões
    this.buttonTargets.forEach(btn => {
      if (btn.dataset.filter === selectedFilter) {
        btn.classList.add("bg-[#003CA5]", "text-white", "border-[#003CA5]", "font-bold", "shadow-md")
        btn.classList.remove("bg-brand-surface", "dark:bg-[#13171F]", "text-brand-tinta/70", "dark:text-neutral-400", "border-brand-tinta/10", "dark:border-white/10", "hover:bg-brand-tinta", "hover:text-brand-surface", "dark:hover:bg-white/10", "dark:hover:text-white")
      } else {
        btn.classList.remove("bg-[#003CA5]", "text-white", "border-[#003CA5]", "font-bold", "shadow-md")
        btn.classList.add("bg-brand-surface", "dark:bg-[#13171F]", "text-brand-tinta/70", "dark:text-neutral-400", "border-brand-tinta/10", "dark:border-white/10", "hover:bg-brand-tinta", "hover:text-brand-surface", "dark:hover:bg-white/10", "dark:hover:text-white")
      }
    })

    // Filtrar itens
    this.itemTargets.forEach(item => {
      const tags = item.dataset.tags || ""
      if (selectedFilter === "Todos" || selectedFilter === "All" || tags.toLowerCase().includes(selectedFilter.toLowerCase())) {
        item.style.display = ""
        // Pequeno delay para animação de fade in (opcional, depende do CSS)
        setTimeout(() => {
          item.style.opacity = "1"
          item.style.transform = "scale(1)"
        }, 50)
      } else {
        item.style.opacity = "0"
        item.style.transform = "scale(0.95)"
        setTimeout(() => {
          item.style.display = "none"
        }, 300) // tempo da transição
      }
    })
  }
}
