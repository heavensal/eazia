import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loader"
export default class extends Controller {
  static targets = ["togglableElement", "chargement"]

  connect() {
    // console.log("je suis connecté")
  }

  fire() {
    this.togglableElementTarget.classList.toggle("d-none");
    this.chargementTarget.classList.toggle("d-none");
    const navbar = document.querySelector("#menu");
    navbar.classList.add("d-none");

  }
}
