import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="landing--calcul"
export default class extends Controller {

  static targets = ["posts", "prixAgence", "prixEazia", "gainEazia"];

  connect() {
    console.log("landing--calcul controller !");
    this.postsTarget.value = '';
  }

  calculate() {
    const inputValue = this.postsTarget.value.trim(); // trim() pour supprimer les espaces en trop

    // Vérifier si l'input est vide ou non numérique
    if (inputValue === '' || isNaN(inputValue)) {
      // Si l'input est vide ou non numérique, les cases restent vides
      this.prixAgenceTarget.textContent = "€";
      this.prixEaziaTarget.textContent = "€";
      this.gainEaziaTarget.textContent = "€";
    } else {
      // Si l'input est valide, faire les calculs
      const nbPosts = parseInt(inputValue);
      const prixAgence = nbPosts * 60;
      const prixEazia = nbPosts <= 15 ? 19 : 59;
      const gainEazia = prixAgence - prixEazia;

      this.prixAgenceTarget.textContent = prixAgence + " €";
      this.prixEaziaTarget.textContent = prixEazia + " €";
      this.gainEaziaTarget.textContent = gainEazia + " €";
    }
  }

}
