import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display"
export default class extends Controller {
  static targets = ["textarea", "modif", "regen", "view"]

  connect() {
    this.viewTarget.classList.remove("decalage");
  }

  fireArea(event) {
    event.preventDefault();

    this.modifTarget.classList.toggle("d-none");
    this.regenTarget.classList.toggle("d-none");
    this.textareaTarget.classList.toggle("d-none");
    this.viewTarget.classList.add("decalage");
  }

  cancelArea(event) {
    event.preventDefault();
    this.modifTarget.classList.toggle("d-none");
    this.regenTarget.classList.toggle("d-none");
    this.textareaTarget.classList.toggle("d-none");
    this.viewTarget.classList.remove("decalage");
  }


}
