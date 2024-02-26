import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ["menu", "navbar", "footer"];



  connect() {
    console.log("je suis là")

    document.body.addEventListener('click', this.handleClickOutside.bind(this));
    this.adjustMenuHeight();
      window.addEventListener('resize', () => this.adjustMenuHeight());
      window.addEventListener('scroll', () => this.adjustMenuHeight());
    }


  disconnect() {
    document.body.removeEventListener('click', this.boundHandleClickOutside);
  }

  toggleMenu(event) {

      // Pour empêcher la fermeture lors du clic sur le menu
      event.stopPropagation();
      this.menuTarget.classList.toggle('sub-menus-open');
      document.body.classList.toggle('sub-menus-open');
  }



//   handleClickOutside(event) {
//     // console.log("est ce qu'il se passe quelque chose ici ? ")
//     //   // Si le clic est en dehors du menu, fermer le menu
//     //   if ((!this.menuTarget.contains(event.target) && this.menuTarget.classList.contains('open')) ||
//     //   (!this.navbarTarget.contains(event.target) && this.navbarTarget.classList.contains('open')) ||
//     //   (!this.footerTarget.contains(event.target) && this.footerTarget.classList.contains('open'))) {
//     // // Ferme menuTarget si ouvert
//     // if (this.menuTarget.classList.contains('open')) {
//     //   this.menuTarget.classList.remove('open');
//   // }
// }

handleClickOutside(event) {
  // Log pour indiquer que le gestionnaire a été déclenché
  console.log("Gestionnaire d'événements handleClickOutside déclenché");

  // Log de l'élément sur lequel le clic a été effectué
  console.log("Élément cliqué :", event.target);

  // Votre logique existante pour fermer le menu si le clic est en dehors
  if (!this.menuTarget.contains(event.target)) {
    this.menuTarget.classList.remove('sub-menus-open');
    console.log("Menu fermé car le clic est en dehors de menuTarget");
  } else {
    console.log("Le clic est à l'intérieur de menuTarget ou le menu n'est pas ouvert; aucune action prise.");
  }
}


  isFooterVisible() {
    const footerRect = this.footerTarget.getBoundingClientRect();
    return footerRect.top < window.innerHeight;
  }


  adjustMenuHeight() {
    const navbarHeight = 10
    const footer = this.footerTarget;
    const viewportHeight = window.innerHeight;


    // Par défaut, la hauteur du menu est égale à la hauteur de la fenêtre du navigateur
    let menuHeight = viewportHeight;

    if (this.navbarTarget) {
     // Si la navbar existe, soustrayez sa hauteur
    menuHeight -= viewportHeight * (navbarHeight /100);
    }

    if (footer && this.isFooterVisible()) {
      // Si le footer existe, soustrayez sa hauteur
      menuHeight -= this.footerTarget.offsetHeight;
    }

    // if (!navbar && !footer) {

    //   // Utilisez la hauteur de la fenêtre du navigateur par défaut
    //   menuHeight = viewportHeight;
    // }

    // Assurez-vous que la hauteur du menu ne soit pas inférieure à 0px


    menuHeight = Math.max(menuHeight, 0);

    this.menuTarget.style.height = `${menuHeight}px`;
  }

}
