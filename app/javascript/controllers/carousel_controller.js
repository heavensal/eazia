import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="carousel"
export default class extends Controller {
  static targets = ["item", "prev", "next"]

  connect() {
    this.updateControls()
  }

  nextSlide() {
    // Trouvez l'index de l'élément actif
    const activeIndex = this.itemTargets.findIndex(target => target.classList.contains("active"))
    // Déplacez vers le prochain si ce n'est pas le dernier
    if (activeIndex < this.itemTargets.length - 1) {
      this.itemTargets[activeIndex].classList.remove("active")
      this.itemTargets[activeIndex + 1].classList.add("active")
    }
    this.updateControls()
  }

  prevSlide() {
    // Trouvez l'index de l'élément actif
    const activeIndex = this.itemTargets.findIndex(target => target.classList.contains("active"))
    // Déplacez vers le précédent si ce n'est pas le premier
    if (activeIndex > 0) {
      this.itemTargets[activeIndex].classList.remove("active")
      this.itemTargets[activeIndex - 1].classList.add("active")
    }
    this.updateControls()
  }

  updateControls() {
    const activeIndex = this.itemTargets.findIndex(target => target.classList.contains("active"))
    this.prevTarget.disabled = activeIndex === 0
    this.nextTarget.disabled = activeIndex === this.itemTargets.length - 1
  }
}
