import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="landing--offer"
export default class extends Controller {
  static targets = ["pricemensuf", "pricetrimf", "priceanuf", "pricemensub", "pricetrimb", "priceanub", "pricemensup", "pricetrimp", "priceanup"]

  connect() {
    console.log("controller landing--offer !");
  }

  convertToTrimester(event) {
    console.log("Vous avez cliqué sur trimestriel");
    // Fonction pour convertir le prix en trimestriel
    const buttonClicked = event.currentTarget;
    const buttons = Array.from(buttonClicked.parentElement.children); // Obtient tous les boutons
    buttons.forEach(button => button.classList.remove('active')); // Supprime la classe active de tous les boutons
    buttonClicked.classList.add('active'); // Ajoute la classe active au bouton cliqué

    this.pricetrimfTarget.innerHTML = '<span class="prix">0€</span><span>/trimestre</span>'; // Met à jour l'affichage du prix
    this.pricetrimbTarget.innerHTML = '<span class="prix">49€</span><span>/trimestre</span>';
    this.pricetrimpTarget.innerHTML = '<span class="prix">159€</span><span>/trimestre</span>';
  }

  convertToMensuel(event) {
    console.log("Vous avez cliqué sur mensuel");
    // Fonction pour convertir le prix en mensuel
    const buttonClicked = event.currentTarget;
    const buttons = Array.from(buttonClicked.parentElement.children); // Obtient tous les boutons
    buttons.forEach(button => button.classList.remove('active')); // Supprime la classe active de tous les boutons
    buttonClicked.classList.add('active'); // Ajoute la classe active au bouton cliqué

    this.pricemensufTarget.innerHTML = '<span class="prix">0€</span><span>/mois</span>'; // Met à jour l'affichage du prix
    this.pricemensubTarget.innerHTML = '<span class="prix prixbarre">19€</span><span>/mois</span> <i class="fa-solid fa-arrow-right"></i><span class="lancement prix">19€</span><span class="lancement"> pour 6 mois !</span>';
    this.pricemensupTarget.innerHTML = '<span class="prix">59€</span><span>/mois</span>';
  }

  convertToAnnuel(event) {
    console.log("Vous avez cliqué sur annuel");
    // Fonction pour convertir le prix en anuel
    const buttonClicked = event.currentTarget;
    const buttons = Array.from(buttonClicked.parentElement.children); // Obtient tous les boutons
    buttons.forEach(button => button.classList.remove('active')); // Supprime la classe active de tous les boutons
    buttonClicked.classList.add('active'); // Ajoute la classe active au bouton cliqué

    this.priceanufTarget.innerHTML = '<span class="prix">0€</span><span>/an</span>'; // Met à jour l'affichage du prix
    this.priceanubTarget.innerHTML = '<span class="prix">159€</span><span>/an</span>';
    this.priceanupTarget.innerHTML = '<span class="prix">489€</span><span>/an</span>';
  }

}
