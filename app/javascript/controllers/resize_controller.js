import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="resize"
export default class extends Controller {
  static targets = ["cgv", "cgu"]

  connect() {
      this.updateText();
      window.addEventListener('resize', () => this.updateText());
  }

   updateText() {
        if (window.innerWidth < 600) {
            // Changer le texte pour les petits écrans
            this.cgvTarget.innerHTML = "CGV";
            this.cguTarget.innerHTML = "CGU";
        } else {
            // Remettre le texte par défaut pour les grands écrans
            this.cgvTarget.innerHTML = "Conditions Générales de Ventes";
            this.cguTarget.innerHTML = "Conditions Générales d'Utilisateurs";
        }
    }
}
