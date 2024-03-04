import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dimension"]

  connect() {
      this.resizeTextarea();
  }

  resizeTextarea() {
      const dimension = this.dimensionTarget;
      dimension.style.height = 'auto'; // Réinitialiser la hauteur
      let newHeight = dimension.scrollHeight;
      if (newHeight > MAX_HEIGHT) {
          newHeight = MAX_HEIGHT; // Appliquer la hauteur maximale
          dimension.style.overflowY = 'scroll';

      } // Ajouter une barre de défilement si nécessaire
      dimension.style.height = `${newHeight}px`;
  }

  updateTextarea() {
    // console.log("coucou")
      this.resizeTextarea();
  }
}

const MAX_HEIGHT = 300;
