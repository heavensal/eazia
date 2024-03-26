import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loader"
export default class extends Controller {
  static targets = ["togglableElement", "chargement"]

  connect() {

  }

  fire() {


    // Vérifier si les targets sont présentes
    // console.log('Has togglableElementTarget:', this.hasTogglableElementTarget);
    // console.log('Has chargementTarget:', this.hasChargementTarget);

    // Effectuer les actions seulement si les targets existent
    if (this.hasTogglableElementTarget && this.hasChargementTarget) {
      this.togglableElementTarget.classList.toggle("d-none");
      this.chargementTarget.classList.toggle("d-none");
      // console.log('Actions de toggle effectuées');
    } else {
      // console.log('Une ou plusieurs targets sont manquantes');
    }
  }
}
