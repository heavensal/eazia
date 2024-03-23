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
    this.modalTarget.classList.add("show");
    this.modalTarget.style.display = "block";
    this.modalTarget.removeAttribute("aria-hidden");
    this.modalTarget.setAttribute("aria-modal", "true");
    this.modalTarget.setAttribute("role", "dialog");
    this.overlayTarget.style.display = "block"; // Afficher l'overlay
    document.body.classList.add("modal-open");

    this.infoTarget.classList.remove("hidden")


  }

  close() {
    this.modalTarget.classList.remove("show");
    this.modalTarget.style.display = "none";
    this.modalTarget.setAttribute("aria-hidden", "true");
    this.modalTarget.removeAttribute("aria-modal");
    this.modalTarget.removeAttribute("role");
    this.overlayTarget.style.display = "none"; // Cacher l'overlay
    document.body.classList.remove("modal-open");

    this.infoTarget.classList.add("hidden")
  }
}
