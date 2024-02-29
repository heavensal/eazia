import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "error", "checkbox", "myErrorMessage", "prompt"]

  connect() {
    console.log('Autorisation form connected');
    this.inputTargets.forEach(input => {
      input.addEventListener('blur', this.validateField.bind(this));
    });
    this.element.addEventListener('submit', this.validateForm.bind(this));

    if (this.hasCheckboxTarget) {
      this.checkboxTarget.addEventListener('change', this.validateForm.bind(this));
    }

    this.submitButton = this.element.querySelector('.btn-inscription') || this.element.querySelector('.btn-valider');
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
    const isPromptValid = this.promptTarget.value.length >= 20;
    let isCheckboxChecked = true;
       // Présumez true si pas de checkbox, pour la logique suivante.
    if (this.hasCheckboxTarget) {
      isCheckboxChecked = this.checkboxTarget.checked;
    }

    if (!isCheckboxChecked || !isPromptValid) {
      event.preventDefault();
      if (this.hasMyErrorMessageTarget) {
      this.myErrorMessageTarget.classList.remove('hidden');
    }
    this.submitButton.disabled = true;

    }

    if (!isPromptValid) {
      this.errorTarget.classList.remove('d-none');
      this.errorTarget.textContent = 'La description doit contenir au moins 20 caractères.';
    }

    else {
      if (this.hasMyErrorMessageTarget) {
      this.myErrorMessageTarget.classList.add('hidden');
      }
      this.errorTarget.classList.add('d-none');
      this.submitButton.disabled = false;
    }
  }

  validatePrompt() {
    const promptText = this.promptTarget.value;
    const isValid = promptText.length >= 20;
    const submitButton = this.element.querySelector('.btn-valider');

    if (!isValid) {
      // Désactiver le bouton de soumission et afficher un message d'erreur
      submitButton.disabled = true;
      this.errorTarget.classList.remove('d-none');
      this.errorTarget.textContent = 'La description doit contenir au moins 20 caractères.';
    } else {
      // Activer le bouton de soumission et cacher le message d'erreur
      submitButton.disabled = false;
      this.errorTarget.classList.add('d-none');
    }
  }

}
