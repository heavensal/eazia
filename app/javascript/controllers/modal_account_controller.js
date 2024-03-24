import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal-account"
export default class extends Controller {
  static targets = ["modal", "overlay", "info"];

  connect(){
    console.log("Modal account controller connected");
  }

  open(event) {
    event.preventDefault();
    event.stopPropagation();

    if (this.hasModalTarget) {
    this.modalTarget.classList.add("show");
    this.modalTarget.style.display = "block";
    this.modalTarget.removeAttribute("aria-hidden");
    this.modalTarget.setAttribute("aria-modal", "true");
    this.modalTarget.setAttribute("role", "dialog");
    }
    if (this.hasOverlayTarget) {
    this.overlayTarget.style.display = "block"; // Afficher l'overlay
    }

    if (this.hasModalTarget || this.hasOverlayTarget || this.infoTarget) {
      document.body.classList.add("modal-open");
    }


    if (this.hasInfoTarget) {
    this.infoTarget.classList.add("show");
    this.infoTarget.style.display = "block";
    this.infoTarget.removeAttribute("aria-hidden");
    this.infoTarget.setAttribute("aria-modal", "true");
    this.infoTarget.setAttribute("role", "dialog");
    }


  }

  close() {
    if (this.hasModalTarget) {
    this.modalTarget.classList.remove("show");
    this.modalTarget.style.display = "none";
    this.modalTarget.setAttribute("aria-hidden", "true");
    this.modalTarget.removeAttribute("aria-modal");
    this.modalTarget.removeAttribute("role");
    }

    if (this.hasOverlayTarget) {
    this.overlayTarget.style.display = "none"; // Cacher l'overlay
    }

    if (this.hasModalTarget || this.hasOverlayTarget || this.infoTarget) {
      document.body.classList.remove("modal-open");
    }

    if (this.hasInfoTarget) {
      console.log("close là")
      this.infoTarget.classList.remove("show");
      this.infoTarget.style.display = "none";
      this.infoTarget.setAttribute("aria-hidden", "true");
      this.infoTarget.removeAttribute("aria-modal");
      this.infoTarget.removeAttribute("role");
    }
  }
}
