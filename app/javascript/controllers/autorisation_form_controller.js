import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "error", "checkbox", "myErrorMessage", "prompt"]

  connect() {
    // Ajout des écouteurs existants
    this.inputTargets.forEach(input => {
      input.addEventListener('blur', this.validateField.bind(this));
    });
    this.element.addEventListener('submit', this.validateForm.bind(this));
    if (this.hasCheckboxTarget) {
      this.checkboxTarget.addEventListener('change', this.validateForm.bind(this));
    }
    this.submitButton = this.element.querySelector('.btn-inscription') || this.element.querySelector('.contenu .main-bouton');

    // Ajouter un nouvel écouteur d'événements pour le champ prompt
    this.promptTarget.addEventListener('input', this.validatePrompt.bind(this));
  }

  validateField(event) {
    const field = event.target;
    const errorTarget = this.errorTarget.find(e => e.getAttribute("data-input-name") === field.name);

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
      this.myErrorMessageTarget.classList.remove('d-none');
      // this.errorTarget.textContent = 'La description doit contenir au moins 20 caractères.';
    }

    else {
      if (this.hasMyErrorMessageTarget) {
      this.myErrorMessageTarget.classList.add('hidden');
      }
      this.myErrorMessageTarget.classList.add('d-none');
      this.submitButton.disabled = false;
    }

    this.triggerLoaderAction();
  }

  triggerLoaderAction() {
    const loaderController = this.application.getControllerForElementAndIdentifier(document.querySelector("[data-controller='loader']"), "loader");

    if (loaderController) {
      loaderController.fire();
    } else {
      console.error("Loader controller not found");
    }
  }

  validatePrompt() {
    const isPromptValid = this.promptTarget.value.length >= 20;
    if (isPromptValid) {
      this.submitButton.disabled = false;
    }
  }

}
