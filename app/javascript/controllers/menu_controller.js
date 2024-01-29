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
      document.body.classList.toggle('menu-open');
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
    const navbar = this.navbarTarget;
    const footer = this.footerTarget;
    const viewportHeight = window.innerHeight;

    // Par défaut, la hauteur du menu est égale à la hauteur de la fenêtre du navigateur
    let menuHeight = viewportHeight;

    if (navbar) {
      // Si la navbar existe, soustrayez sa hauteur
      menuHeight -= navbar.offsetHeight;
    }

    if (footer) {
      // Si le footer existe, soustrayez sa hauteur
      const isFooterVisible = this.isFooterVisible();

      if (isFooterVisible) {
      // Si le pied de page est visible, soustrayez sa hauteur
      menuHeight -= footer.offsetHeight;
      }
    }

    if (!navbar && !footer) {

      // Utilisez la hauteur de la fenêtre du navigateur par défaut
      menuHeight = viewportHeight;
    }

    // Assurez-vous que la hauteur du menu ne soit pas inférieure à 0px
    menuHeight = Math.max(menuHeight, 0);

    this.menuTarget.style.height = `${menuHeight}px`;
  }

}
