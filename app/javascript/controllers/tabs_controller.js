import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.showPanel(0)
  }

  switch(event) {
    if (event) event.preventDefault()
    
    // Fallback robusto para encontrar os botões de tabulação no escopo deste controller
    const tabs = Array.from(this.element.querySelectorAll('[data-tabs-target="tab"]'))
    let button = event.currentTarget
    
    // Se por acaso o currentTarget falhar, busque pelo elemento mais próximo
    if (!button || !button.hasAttribute('data-tabs-target')) {
      button = event.target.closest('[data-tabs-target="tab"]')
    }
    
    const index = tabs.indexOf(button)
    if (index !== -1) {
      this.showPanel(index)
    }
  }

  showPanel(index) {
    const panels = Array.from(this.element.querySelectorAll('[data-tabs-target="panel"]'))
    const tabs = Array.from(this.element.querySelectorAll('[data-tabs-target="tab"]'))
    
    panels.forEach((panel, i) => {
      if (i === index) {
        panel.classList.remove("hidden")
      } else {
        panel.classList.add("hidden")
      }
    })

    tabs.forEach((tab, i) => {
      if (i === index) {
        tab.classList.add("bg-[#003CA5]", "hover:bg-[#002361]", "text-white", "shadow-lg", "border-[#003CA5]")
        tab.classList.remove("text-neutral-600", "dark:text-neutral-400", "hover:text-brand-tinta", "dark:hover:text-white", "hover:bg-brand-tinta/5", "dark:hover:bg-white/10", "border-brand-tinta/10", "dark:border-white/10", "bg-brand-surface", "dark:bg-[#13171F]")
      } else {
        tab.classList.remove("bg-[#003CA5]", "hover:bg-[#002361]", "text-white", "shadow-lg", "border-[#003CA5]")
        tab.classList.add("text-neutral-600", "dark:text-neutral-400", "hover:text-brand-tinta", "dark:hover:text-white", "hover:bg-brand-tinta/5", "dark:hover:bg-white/10", "border-brand-tinta/10", "dark:border-white/10", "bg-brand-surface", "dark:bg-[#13171F]")
      }
    })
  }
}
