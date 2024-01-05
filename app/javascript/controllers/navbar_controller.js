import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ['nav', 'menu']

  connect() {
  }

  toggle() {
    console.log("Toggle method called");
    if (this.navTarget.classList.contains('overflow-hidden')) {
      this.navTarget.classList.remove('overflow-hidden');
      this.menuTarget.classList.add('toggle');
    } else {
      this.menuTarget.classList.remove('toggle');
      setTimeout(() => {
        this.navTarget.classList.add('overflow-hidden');
      }, 500);
    };
  }
}
