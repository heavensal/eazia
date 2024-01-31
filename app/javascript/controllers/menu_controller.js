import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ["menu", "navbar", "footer"];

  connect() {
      document.addEventListener('click', this.handleClickOutside.bind(this));
      this.adjustMenuHeight();
      window.addEventListener('resize', () => this.adjustMenuHeight());
      window.addEventListener('scroll', () => this.adjustMenuHeight());
    }


  disconnect() {
      document.removeEventListener('click', this.handleClickOutside.bind(this));
  }

  toggle(event) {
      // Pour empêcher la fermeture lors du clic sur le menu
      event.stopPropagation();
      this.menuTarget.classList.toggle('open');
      document.body.classList.toggle('sub-menus-open');
  }

  handleClickOutside(event) {
      // Si le clic est en dehors du menu, fermer le menu
      if (!this.menuTarget.contains(event.target) && this.menuTarget.classList.contains('open')) {
          this.menuTarget.classList.remove('open');
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
