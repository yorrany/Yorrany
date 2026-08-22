import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "item"]

  filter(event) {
    const selectedKey = (event.currentTarget.dataset.filter || "all").toLowerCase()
    
    // Atualizar estado visual dos botões de filtro
    this.buttonTargets.forEach(btn => {
      const btnKey = (btn.dataset.filter || "").toLowerCase()
      if (btnKey === selectedKey) {
        btn.classList.add("bg-[#003CA5]", "text-white", "border-[#003CA5]", "font-bold", "shadow-md")
        btn.classList.remove("bg-brand-surface", "dark:bg-[#13171F]", "text-brand-tinta/70", "dark:text-neutral-300", "border-brand-tinta/10", "dark:border-white/10")
      } else {
        btn.classList.remove("bg-[#003CA5]", "text-white", "border-[#003CA5]", "font-bold", "shadow-md")
        btn.classList.add("bg-brand-surface", "dark:bg-[#13171F]", "text-brand-tinta/70", "dark:text-neutral-300", "border-brand-tinta/10", "dark:border-white/10")
      }
    })

    const isAll = selectedKey === "all" || ["todos", "all"].includes(selectedKey)

    // Filtrar itens com animação suave
    this.itemTargets.forEach(item => {
      const keys = (item.dataset.filterKeys || "").toLowerCase()
      const tags = (item.dataset.tags || "").toLowerCase()
      const matches = isAll || keys.includes(selectedKey) || tags.includes(selectedKey)

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
