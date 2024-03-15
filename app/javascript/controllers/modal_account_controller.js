import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal-account"
export default class extends Controller {
  static targets = ["modal"];

  connect(){
    console.log("je suis connecté à mon modal account")

  }

  open(event) {
    event.preventDefault();
    this.modalTarget.classList.add("show");
    this.modalTarget.style.display = "block";
    this.modalTarget.removeAttribute("aria-hidden");
    this.modalTarget.setAttribute("aria-modal", "true");
    this.modalTarget.setAttribute("role", "dialog");
    document.body.classList.add("modal-open");
  }

  close() {
    this.modalTarget.classList.remove("show");
    this.modalTarget.style.display = "none";
    this.modalTarget.setAttribute("aria-hidden", "true");
    this.modalTarget.removeAttribute("aria-modal");
    this.modalTarget.removeAttribute("role");
    document.body.classList.remove("modal-open");
  }
}
