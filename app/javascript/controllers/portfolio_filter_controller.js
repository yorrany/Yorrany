import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "item", "carousel", "prevBtn", "nextBtn"]

  connect() {
    this.updateCarouselState()
    this.handleScroll = this.updateCarouselState.bind(this)
    if (this.hasCarouselTarget) {
      this.carouselTarget.addEventListener("scroll", this.handleScroll, { passive: true })
    }
  }

  disconnect() {
    if (this.hasCarouselTarget && this.handleScroll) {
      this.carouselTarget.removeEventListener("scroll", this.handleScroll)
    }
  }

  filter(event) {
    const selectedFilter = event.currentTarget.dataset.filter
    
    // Atualizar estado visual dos botões de filtro
    this.buttonTargets.forEach(btn => {
      if (btn.dataset.filter === selectedFilter) {
        btn.classList.add("bg-[#003CA5]", "text-white", "border-[#003CA5]", "font-bold", "shadow-md")
        btn.classList.remove("bg-brand-surface", "dark:bg-[#13171F]", "text-brand-tinta/70", "dark:text-neutral-400", "border-brand-tinta/10", "dark:border-white/10", "hover:bg-brand-tinta", "hover:text-brand-surface", "dark:hover:bg-white/10", "dark:hover:text-white")
      } else {
        btn.classList.remove("bg-[#003CA5]", "text-white", "border-[#003CA5]", "font-bold", "shadow-md")
        btn.classList.add("bg-brand-surface", "dark:bg-[#13171F]", "text-brand-tinta/70", "dark:text-neutral-400", "border-brand-tinta/10", "dark:border-white/10", "hover:bg-brand-tinta", "hover:text-brand-surface", "dark:hover:bg-white/10", "dark:hover:text-white")
      }
    })

    const isAll = ["Todos", "All", "todos", "all"].includes(selectedFilter.toLowerCase())

    // Filtrar itens
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
        item.style.transform = "scale(0.95)"
        setTimeout(() => {
          item.style.display = "none"
          this.updateCarouselState()
        }, 250)
      }
    })

    // Reset de scroll para o início
    if (this.hasCarouselTarget) {
      this.carouselTarget.scrollTo({ left: 0, behavior: "smooth" })
    }
  }

  scrollPrev() {
    if (!this.hasCarouselTarget) return
    const scrollAmount = this.getScrollStep()
    this.carouselTarget.scrollBy({ left: -scrollAmount, behavior: "smooth" })
  }

  scrollNext() {
    if (!this.hasCarouselTarget) return
    const scrollAmount = this.getScrollStep()
    this.carouselTarget.scrollBy({ left: scrollAmount, behavior: "smooth" })
  }

  getScrollStep() {
    if (!this.hasCarouselTarget) return 300
    const visibleCards = this.itemTargets.filter(item => item.style.display !== "none")
    if (visibleCards.length > 0) {
      const firstCard = visibleCards[0]
      const cardWidth = firstCard.getBoundingClientRect().width
      const style = window.getComputedStyle(this.carouselTarget)
      const gap = parseFloat(style.columnGap || style.gap || 16)
      return cardWidth + gap
    }
    return this.carouselTarget.clientWidth * 0.75
  }

  updateCarouselState() {
    if (!this.hasCarouselTarget) return

    const { scrollLeft, scrollWidth, clientWidth } = this.carouselTarget
    const isAtStart = scrollLeft <= 10
    const isAtEnd = scrollLeft + clientWidth >= scrollWidth - 10

    if (this.hasPrevBtnTarget) {
      if (isAtStart) {
        this.prevBtnTarget.classList.add("opacity-30", "cursor-not-allowed", "pointer-events-none")
        this.prevBtnTarget.setAttribute("aria-disabled", "true")
      } else {
        this.prevBtnTarget.classList.remove("opacity-30", "cursor-not-allowed", "pointer-events-none")
        this.prevBtnTarget.removeAttribute("aria-disabled")
      }
    }

    if (this.hasNextBtnTarget) {
      if (isAtEnd) {
        this.nextBtnTarget.classList.add("opacity-30", "cursor-not-allowed", "pointer-events-none")
        this.nextBtnTarget.setAttribute("aria-disabled", "true")
      } else {
        this.nextBtnTarget.classList.remove("opacity-30", "cursor-not-allowed", "pointer-events-none")
        this.nextBtnTarget.removeAttribute("aria-disabled")
      }
    }
  }
}
