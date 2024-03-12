import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-submission"
export default class extends Controller {
  static targets = ["loadingSpinner", "submitButton", "images", "submitButtonImages"];

  submit(event) {
    this.loadingSpinnerTarget.hidden = false;
    this.submitButtonTarget.style.display = 'none';
  }

  submitImage(event){
    this.imagesTarget.hidden = false;
  }

}
