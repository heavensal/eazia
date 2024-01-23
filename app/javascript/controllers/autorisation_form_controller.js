import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "error", "checkbox", "myErrorMessage"]

  connect() {
    console.log('Autorisation form connected');
    this.inputTargets.forEach(input => {
      input.addEventListener('blur', this.validateField.bind(this));
    });

    this.element.addEventListener('submit', this.validateForm.bind(this));


    this.checkboxTarget.addEventListener('change', this.validateForm.bind(this));


    this.submitButton = this.element.querySelector('.btn-inscription');
  }

  validateField(event) {
    const field = event.target;
    const errorTarget = this.errorTargets.find(e => e.getAttribute("data-input-name") === field.name);

    if (!field.value) {
      field.classList.add("is-invalid");
      errorTarget.classList.remove('d-none');
    } else {
      field.classList.remove("is-invalid");
      errorTarget.classList.add('d-none');
    }
  }

  validateForm(event) {
    if (!this.checkboxTarget.checked) {
      event.preventDefault();
      this.myErrorMessageTarget.classList.remove('hidden');
      this.submitButton.disabled = true;
    } else {
      this.myErrorMessageTarget.classList.add('hidden');
      this.submitButton.disabled = false;
    }

   }
}
