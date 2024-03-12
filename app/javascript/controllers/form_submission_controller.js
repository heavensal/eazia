import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-submission"
export default class extends Controller {
  static targets = ["loadingSpinner", "submitButton"];

  submit(event) {
    this.loadingSpinnerTarget.hidden = false; // Affiche le spinner
    this.submitButtonTarget.style.display = 'none'; // Cache le bouton de soumission
  }

}
