import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggledescription"
export default class extends Controller {
  static targets = ["description", "plus"]

  connect() {
    // console.log("toggle connected");
  }

  fireplus() {
    this.descriptionTargets.forEach(span => {
      span.classList.toggle("d-none");
    });
    this.plusTargets.forEach(span => {
      span.classList.toggle("d-none");
    });
  }

  disconnect() {
  }
}
